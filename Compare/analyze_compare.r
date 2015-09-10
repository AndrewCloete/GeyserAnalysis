
start_threshold <- 0.5
stop_threshold <- 0.5

print(ln)
print(sprintf("Start detection threshold: %0.1f litres", start_threshold))
print(sprintf("Stop detection threshold: %0.1f litres", stop_threshold))
print(ln)

# ------------------------------- Detect and combine events ----------------------------------------- #
events <- list()
for(i in 1:date_count){

	hot_events <- event_detect(subsets[[i]]$server_stamp, subsets[[i]]$hot_flow_dif, start_threshold, stop_threshold, 1)
	colnames(hot_events) <- c("start_time", "duration", "volume", "mean_flowrate", "type")
	hot_events$start_time <- as.POSIXct(hot_events$start_time, origin="1970-01-01")

	cold_events <- event_detect(subsets[[i]]$server_stamp, subsets[[i]]$cold_flow_dif, start_threshold, stop_threshold, 2)
	colnames(cold_events) <- c("start_time", "duration", "volume", "mean_flowrate", "type")
	cold_events$start_time <- as.POSIXct(cold_events$start_time, origin="1970-01-01")


	e <- rbind(hot_events, cold_events)
	e$pcol[e$type==1] <- "Hot"	# This becomes the LABLE, not the actual color
	e$pcol[e$type==2] <- "Cold"
	print("------------------------ List of events ------------------------")
	print(e)
	events[[i]] <- e
# ----------------------------------------------------------------------------------------------------- #

}
