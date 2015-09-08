timetamp_diff <- function(timestamps){

	diff <- data.frame(start_time=numeric(), diff=numeric())

	for(i in 1:length(timestamps)-1){ 
		start = as.numeric(timestamps[i])
		timediff = as.numeric(timestamps[i+1]-timestamps[i], units = "mins")
	
		diff <- rbind(diff, c(start, timediff))
	}

	
	return(diff)
}
