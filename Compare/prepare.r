ln <- "----------------------------------------------------------------"

#----------------------  Caluclate comms delta transmission time and add to date----------------------- #
server_stamp_diff <- timetamp_diff(as.POSIXct(strptime(geyser_data$server_stamp, "%Y-%m-%d %H:%M:%S")))
client_stamp_diff <- timetamp_diff(as.POSIXct(strptime(geyser_data$client_stamp, "%Y-%m-%d %H:%M:%S")))
colnames(server_stamp_diff) <- c("start_time", "diff")
colnames(client_stamp_diff) <- c("start_time", "diff")


# 
geyser_data$delta_server_stamp <- server_stamp_diff$diff
geyser_data$delta_client_stamp <- client_stamp_diff$diff
# ----------------------------------------------------------------------------------------------------- #






# ----------------------------   Differentiate acc volume to get flow   ------------------------------ #
geyser_data$hot_flow_dif <- dif(geyser_data$hot_litres_tot)
geyser_data$cold_flow_dif <- dif(geyser_data$cold_litres_tot)
geyser_data$kwatt_dif <- dif(geyser_data$kwatt_tot)
# ----------------------------------------------------------------------------------------------------- #








# --------------------------------   Split the data into subsets   ------------------------------------ #
subsets <- list()

for(i in 1:date_count){

subsets[[i]] <- subset(geyser_data, # Note the use of [[]]
			server_stamp >= as.POSIXct(start_dates[i]) & 
			server_stamp <= as.POSIXct(end_dates[i]))

}
# ----------------------------------------------------------------------------------------------------- #
