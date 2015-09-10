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
				"sd_cold_flowrate")


# ----------------------------------- Interesting metrics --------------------------------------------- #

period_metrics <- data.frame()
print(ln)
for(i in 1:date_count){

	m <- metrics(subsets[[i]], events[[i]])
	colnames(m) <- metric_colnames

	print(sprintf("Results for Geyser: %i from %s to %s", geyser_id, 
		strftime(as.POSIXct(m$start_time, origin="1970-01-01")), 
		strftime(as.POSIXct(m$end_time, origin="1970-01-01"))))
	print(ln)

	print(sprintf("VOLUME total: %0.01f litres", m$total_hot_volume + m$total_cold_volume))
	print(sprintf("HOT volume total: %0.01f litres", m$total_hot_volume))
	print(sprintf("COLD volume total: %0.01f litres", m$total_cold_volume))

	print(sprintf("HOT event count: %i", m$hot_event_count))
	print(sprintf("COLD event count: %i", m$cold_event_count))

	print(sprintf("Max HOT event volume: %0.01f litres", m$max_hot_volume))
	print(sprintf("Max COLD event volume: %0.01f litres", m$max_cold_volume))
	print(sprintf("Mean HOT event volume: %0.01f litres", m$mean_hot_volume))
	print(sprintf("Mean COLD event volume: %0.01f litres", m$mean_cold_volume))
	print(sprintf("SD HOT event volume: %0.01f litres", m$sd_hot_volume))
	print(sprintf("SD COLD event volume: %0.01f litres", m$sd_cold_volume))

	print(sprintf("Max HOT event duration: %0.01f min", m$max_hot_duration))
	print(sprintf("Max COLD event duration: %0.01f min", m$max_cold_duration))
	print(sprintf("Mean HOT event duration: %0.01f min", m$mean_hot_duration))
	print(sprintf("Mean COLD event duration: %0.01f min", m$mean_cold_duration))
	print(sprintf("SD HOT event duration: %0.01f min", m$sd_hot_duration))
	print(sprintf("SD COLD event duration: %0.01f min", m$sd_cold_duration))

	print(sprintf("Max HOT event flowrate: %0.01f litres/min", m$max_hot_flowrate))
	print(sprintf("Max COLD event flowrate: %0.01f litres/min", m$max_cold_flowrate))
	print(sprintf("Mean HOT event flowrate: %0.01f litres/min", m$mean_hot_flowrate))
	print(sprintf("Mean COLD event flowrate: %0.01f litres/min", m$mean_cold_flowrate))
	print(sprintf("SD HOT event flowrate: %0.01f litres/min", m$sd_hot_flowrate))
	print(sprintf("SD COLD event flowrate: %0.01f litres/min", m$sd_cold_flowrate))

	print(sprintf("ENERGY total: %0.01f kwatt-h", m$total_energy))
	print(ln)

	period_metrics <- rbind(period_metrics, m)
}


write.table(period_metrics, file = sprintf("~/Geyser/Metrics/metrics_%i.csv", geyser_id), 
		append = FALSE, quote = FALSE, sep = ",",
            	eol = "\n", na = "NA", dec = ".", row.names = FALSE,
            	col.names = TRUE, qmethod = c("escape", "double"),
            	fileEncoding = "")

# ---------------------------------------------------------------------------------------------------- #
