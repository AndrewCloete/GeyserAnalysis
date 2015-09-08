threshold <- 1

# ------------------------------- Detect and combine events ----------------------------------------- #
hot_flow <- flow_dif(geyser_data$hot_litres_tot)
hot_events <- event_detect(data_serverstamp, hot_flow, threshold, 1)
colnames(hot_events) <- c("start_time", "duration", "volume", "mean_flowrate", "type")
hot_events$start_time <- as.POSIXct(hot_events$start_time, origin="1970-01-01")

cold_flow <- flow_dif(geyser_data$cold_litres_tot)
cold_events <- event_detect(data_serverstamp, cold_flow, threshold, 2)
colnames(cold_events) <- c("start_time", "duration", "volume", "mean_flowrate", "type")
cold_events$start_time <- as.POSIXct(cold_events$start_time, origin="1970-01-01")


events <- rbind(hot_events, cold_events)
events$pcol[events$type==1] <- "Hot"	# This becomes the LABLE, not the actual color
events$pcol[events$type==2] <- "Cold"
print("------------------------ List of events ------------------------")
print(events)
# ----------------------------------------------------------------------------------------------------- #




# ------------------------------- Inspect and caculate data sanity ------------------------------------ #
server_stamp_diff <- timetamp_diff(as.POSIXct(strptime(geyser_data$server_stamp, "%Y-%m-%d %H:%M:%S")))
client_stamp_diff <- timetamp_diff(as.POSIXct(strptime(geyser_data$client_stamp, "%Y-%m-%d %H:%M:%S")))
colnames(server_stamp_diff) <- c("start_time", "diff")
colnames(client_stamp_diff) <- c("start_time", "diff")
# ----------------------------------------------------------------------------------------------------- #
