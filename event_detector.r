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


cost <- function(enthalpy, volume){

	enthalpy_kwh <- enthalpy/(1000*3600)

	c <- enthalpy_kwh*1.5 + volume*0.03

	return(c)
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

	print(sprintf("Number of events: %g", nrow(events)))
	if(nrow(events)==0){
		events <- data.frame(timestamps[1], 0.0, 0.0, 0.0, 0.0, 0.0)
	}

	return(events)
}



extract_events <- function(data){

	hot_events <- event_detect(data, "hot_flow_dif", start_threshold, stop_threshold)
	cold_events <- event_detect(data, "cold_flow_dif", start_threshold, stop_threshold)


	hot_events$type <- "hot"
	cold_events$type <- "cold"

	#Assign same collum names to both HOT and COLD events.
	colnames(hot_events) <- c("start_time", "volume", "duration", "mean_flowrate", "mean_temp_out", "mean_temp_in", "type")
	colnames(cold_events) <- colnames(hot_events)

	hot_events$start_time <- as.POSIXct(hot_events$start_time, origin="1970-01-01")
	cold_events$start_time <- as.POSIXct(cold_events$start_time, origin="1970-01-01")


	# Calculate enthalpy of water leaving due to HOT event
	enth <- vector()
	for(i in 1:length(hot_events$type)){
		enth[i] <- enthalpy(hot_events$volume[i], hot_events$mean_temp_out[i], hot_events$mean_temp_in[i])
	}

	# Create and assign "enthalpy" column for events
	hot_events$enthalpy <- enth
	cold_events$enthalpy <- 0


	#Combine events into a single dataframe
	e <- rbind(hot_events, cold_events)

	#Calculate estimated cost for each event due to ENTHALPY and VOLUME
	c <- vector()
	for(i in 1:length(e$type)){
		c[i] <- cost(e$enthalpy[i], e$volume[i])
	}

	# Create and assign "cost" column for events
	e$est_cost <- c

	return(e)


}

extract_hot_events <- function(data, start_threshold, stop_threshold){
	hot_events <- event_detect(data, "hot_flow_dif", start_threshold, stop_threshold)

	hot_events$type <- "hot"

	#Assign same collum names toHOT events.
	colnames(hot_events) <- c("start_time", "volume", "duration", "mean_flowrate", "mean_temp_out", "mean_temp_in", "type")

	hot_events$start_time <- as.POSIXct(hot_events$start_time, origin="1970-01-01")

	# Calculate enthalpy of water leaving due to HOT event
	enth <- vector()
	for(i in 1:length(hot_events$type)){
		enth[i] <- enthalpy(hot_events$volume[i], hot_events$mean_temp_out[i], hot_events$mean_temp_in[i])
	}

	# Create and assign "enthalpy" column for events
	hot_events$enthalpy <- enth/(1000*3600)

	return(hot_events)
}
