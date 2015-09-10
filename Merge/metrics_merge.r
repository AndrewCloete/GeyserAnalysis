ln <- "----------------------------------------------------------------"

# ----------------------------------- Interesting metrics --------------------------------------------- #
start_time = min(geyser_data$server_stamp)
end_time = max(geyser_data$server_stamp)
time_dif_hours = as.numeric(end_time - start_time, units = "hours")

max_outlet_temp <- max(geyser_data$t1)
min_inlet_temp <- min(geyser_data$t3)
max_ambient_temp <- max(geyser_data$t4)
min_ambient_temp <- min(geyser_data$t4)

max_acc_hot_volume <- max(geyser_data$hot_litres_tot) 
max_acc_cold_volume <- max(geyser_data$cold_litres_tot)
max_acc_volume <- max (max_acc_hot_volume, max_acc_cold_volume)

max_hot_volume <- max(hot_events$volume)	
max_cold_volume <- max(cold_events$volume)
max_volume <- max(max_hot_volume, max_cold_volume)

max_hot_duration <- max(hot_events$duration)
max_cold_duration <- max(cold_events$duration)
max_duration <- max(max_hot_duration, max_cold_duration)

max_hot_flowrate <- max(hot_events$mean_flowrate)
max_cold_flowrate <- max(cold_events$mean_flowrate)
max_flowrate <- max(max_hot_flowrate, max_cold_flowrate)

hot_event_count <- length(hot_events$type)-1 # Subtract ZERO event
cold_event_count <- length(cold_events$type)-1

all_minutes <- seq(start_time, end_time, by="min")
midnights <- subset(all_minutes, format(all_minutes, "%H:%M") == "02:00")
print(ln)
print(sprintf("Results for Geyser: %i", geyser_id))
print(ln)
print(sprintf("Detection threshold: %0.1f litres", threshold))
print(ln)
print(sprintf("HOT event count: %i", hot_event_count))
print(sprintf("COLD event count: %i", cold_event_count))
print(sprintf("Max HOT event volume: %0.01f litres", max_hot_volume))
print(sprintf("Max COLD event volume: %0.01f litres", max_cold_volume))
print(sprintf("Max HOT event duration: %0.01f min", max_hot_duration))
print(sprintf("Max COLD event duration: %0.01f min", max_cold_duration))
print(sprintf("Max HOT event flowrate: %0.01f litres/min", max_hot_flowrate))
print(sprintf("Max COLD event flowrate: %0.01f litres/min", max_cold_flowrate))
# ---------------------------------------------------------------------------------------------------- #
