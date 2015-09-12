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

enthalpy <- function(volume, temp, ref_temp){

	e <- 4184*1000*(volume * 0.001)*(temp - ref_temp)
	return(e)
}

event_detect <- function(data, flow_name, start_threshold, stop_threshold){


	timestamps <- data$server_stamp


	flow <- data[,flow_name]	
	temp_out <- data$t1
	temp_in <- data$t3

	#print(temp[366:391])	
	events <- data.frame()

	start_time <- timestamps[1] 
	volume_counter <- 0
	temp_out_sum <- 0
	temp_in_sum <- 0
	count <- 0

	detect_state <- 1

	for(i in 1:length(flow)){ 

		#Wait for event to start
		if(detect_state==1){
			if(flow[i] >= start_threshold){
				volume_counter <- flow[i]
				start_time <- timestamps[i]
				temp_out_sum <- temp_out[i]
				temp_in_sum <- temp_in[i]
				count <- 1
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
				mean_temp_out <- temp_out_sum/count
				mean_temp_in <- temp_in_sum/count

				events <- rbind(events, c(start_time, volume_counter, duration, mean_flowrate, mean_temp_out, mean_temp_in))
				

				volume_counter <- 0
				temp_out_sum <- 0
				temp_in_sum <- 0
				count <- 0
				detect_state <- 1
			}
			else{
				volume_counter <- volume_counter + flow[i]
				temp_out_sum <- temp_out_sum + temp_out[i]
				temp_in_sum <- temp_in_sum + temp_in[i]
				count <- count +1;
			}
		}		
	}

	return(events)
}


event_colnames <- c("start_time", "volume", "duration", "mean_flowrate", "mean_temp_out", "mean_temp_in", "type")

extract_events <- function(data){

	hot_events <- event_detect(data, "hot_flow_dif", 0.1, 0.1)
	cold_events <- event_detect(data, "cold_flow_dif", 0.1, 0.1)	

	hot_events$type <- "hot"
	cold_events$type <- "cold"
	
	
	colnames(hot_events) <- event_colnames 
	colnames(cold_events) <- event_colnames 


	test <- vector()
	for(i in 1:length(hot_events$type)){	
		test[i] <- enthalpy(hot_events$volume[i], hot_events$mean_temp_out[i], hot_events$mean_temp_in[i])
	}

	hot_events$enthalpy <- test/(1000*3600)
	cold_events$enthalpy <- 0

	e <- rbind(hot_events, cold_events)

	return(e)


}


