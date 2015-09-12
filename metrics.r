metrics <- function(data, events){

	start_time <- min(data$server_stamp)
	end_time <- max(data$server_stamp)
	time_dif_hours <- as.numeric(end_time - start_time, units = "hours")

	max_outlet_temp <- max(data$t1)
	min_inlet_temp <- min(data$t3)
	max_ambient_temp <- max(data$t4)
	min_ambient_temp <- min(data$t4)

	max_acc_hot_volume <- max(data$hot_litres_tot) 
	max_acc_cold_volume <- max(data$cold_litres_tot)
	max_acc_volume <- max (max_acc_hot_volume, max_acc_cold_volume)

	total_hot_volume <- sum(data$hot_flow_dif)
	total_cold_volume <- sum(data$cold_flow_dif)

	total_energy <- sum(data$kwatt_dif)

	#--------------------------------------------------------------------------------------	

	#print(events)

	hot_events <- subset(events, type=="hot")
	cold_events <- subset(events, type=="cold")

	hot_event_count <- length(hot_events$type)-1 # Subtract ZERO event
	cold_event_count <- length(cold_events$type)-1

	max_hot_volume <- max(hot_events$volume)	
	max_cold_volume <- max(cold_events$volume)
	max_volume <- max(max_hot_volume, max_cold_volume)
	mean_hot_volume <- mean(hot_events$volume)	
	mean_cold_volume <- mean(cold_events$volume)
	sd_hot_volume <- sd(hot_events$volume)
	sd_cold_volume <- sd(cold_events$volume)


	max_hot_duration <- max(hot_events$duration)
	max_cold_duration <- max(cold_events$duration)
	max_duration <- max(max_hot_duration, max_cold_duration)
	mean_hot_duration <- mean(hot_events$duration)
	mean_cold_duration <- mean(cold_events$duration)
	sd_hot_duration <- sd(hot_events$duration)
	sd_cold_duration <- sd(cold_events$duration)


	max_hot_flowrate <- max(hot_events$mean_flowrate)
	max_cold_flowrate <- max(cold_events$mean_flowrate)
	max_flowrate <- max(max_hot_flowrate, max_cold_flowrate)
	mean_hot_flowrate <- mean(hot_events$mean_flowrate)
	mean_cold_flowrate <- mean(cold_events$mean_flowrate)
	sd_hot_flowrate <- sd(hot_events$mean_flowrate)
	sd_cold_flowrate <- sd(cold_events$mean_flowrate)

	event_energy_out <- sum(hot_events$enthalpy)

	v <- c(	start_time,
		end_time,
		time_dif_hours,
		max_outlet_temp,
		min_inlet_temp,
		max_ambient_temp,
		min_ambient_temp,
		max_acc_hot_volume,
		max_acc_cold_volume,
		max_acc_volume,
		total_hot_volume,
		total_cold_volume,
		total_energy,

		hot_event_count,
		cold_event_count,
		max_hot_volume,
		max_cold_volume,
		mean_hot_volume,
		mean_cold_volume,
		sd_hot_volume,
		sd_cold_volume,

		max_hot_duration,
		max_cold_duration,
		max_duration,
		mean_hot_duration,
		mean_cold_duration,
		sd_hot_duration,
		sd_cold_duration,

		max_hot_flowrate,
		max_cold_flowrate,
		max_hot_flowrate,
		max_flowrate,
		mean_hot_flowrate,
		mean_cold_flowrate,
		sd_hot_flowrate,
		sd_cold_flowrate,
		event_energy_out)
			

	m <- data.frame()
	m <- rbind(m, v)

	return(m)
}


metric_colnames <- c(	"start_time",
			"end_time",
			"time_dif_hours",
			"max_outlet_temp",
			"min_inlet_temp",
			"max_ambient_temp",
			"min_ambient_temp",
			"max_acc_hot_volume",
			"max_acc_cold_volume",
			"max_acc_volume",
			"total_hot_volume",
			"total_cold_volume",
			"total_energy",

			"hot_event_count",
			"cold_event_count",
			"max_hot_volume",
			"max_cold_volume",
			"mean_hot_volume",
			"mean_cold_volume",
			"sd_hot_volume",
			"sd_cold_volume",

			"max_hot_duration",
			"max_cold_duration",
			"max_duration",
			"mean_hot_duration",
			"mean_cold_duration",
			"sd_hot_duration",
			"sd_cold_duration",

			"max_hot_flowrate",
			"max_cold_flowrate",
			"max_hot_flowrate",
			"max_flowrate",
			"mean_hot_flowrate",
			"mean_cold_flowrate",
			"sd_hot_flowrate",
			"sd_cold_flowrate",
			"event_energy_out")

