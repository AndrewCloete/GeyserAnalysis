dif <- function(accumulative){

	diff  <- vector()	

	diff[1] <- accumulative[1]

	for(i in 2:length(accumulative)){ 

		diff[i] <- accumulative[i] - accumulative[i-1]
		if(diff[i] < 0){
			print("Warning: Inconsistant accumulative data")
			diff[i] <- 0
		}

	}

	return(diff)
}

event_detect <- function(timestamps, flow, start_threshold, stop_threshold, type){

	events <- data.frame(start_time = as.numeric(timestamps[1]), volume_counter = 0, duration = 0, mean_flowrate = 0, type = type)

	start_time <- timestamps[1] 
	volume_counter <- 0;

	detect_state <- 1

	for(i in 1:length(flow)){ 

		#Wait for event to start
		if(detect_state==1){
			if(flow[i] >= start_threshold){
				volume_counter <- flow[i]
				start_time <- timestamps[i]
				detect_state <- 2
			}
		}
		#Event is busy
		else if(detect_state==2){
			
			running_duration <- as.numeric(timestamps[i]-start_time, units = "secs")/60			

			#Event has finnished
			if(flow[i] <= stop_threshold && running_duration > 0.1){
				#Calculate time difference (duration)
				#Calulate mean flow rate
				#Store in matrix
				#Reset flow_counter
				duration <- running_duration
				mean_flowrate = volume_counter/(duration)
				events <- rbind(events, 
					c(start_time, duration, volume_counter, mean_flowrate, type))
				
				volume_counter <- 0
				detect_state <- 1
			}
			else
				volume_counter <- volume_counter + flow[i]
		}		
	}

	return(events)
}
