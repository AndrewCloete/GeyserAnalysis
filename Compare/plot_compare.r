library(ggplot2)
library(scales) # to access breaks/formatting functions

output_file <- sprintf("~/Geyser/Plots/Compare/geyser_%i.svg", geyser_id)

#Plot parameters
time_scale <- 12
plot_width <- 20

#png(file=output_file, res = 120, width = 1000, height = 500)
svg(file=output_file, width=plot_width)
par(mfrow=c(1,1))

for(i in 1:date_count){
	s <- ggplot(subsets[[i]])
	s <- s + geom_line( aes(y=t1, x=server_stamp, color="Outlet"), show_guide=TRUE) 
	s <- s + geom_line( aes(y=t2, x=server_stamp, color="Far"), show_guide=TRUE) 
	s <- s + geom_line( aes(y=t3, x=server_stamp, color="Inlet"), show_guide=TRUE) 
	s <- s + geom_line( aes(y=t4, x=server_stamp, color="Abmient"), show_guide=TRUE) 
	s <- s + geom_line( aes(y=watt_avgpmin, x=server_stamp, color = "Power"), show_guide=TRUE) 
	s <- s + geom_vline(xintercept = as.numeric(c(period_metrics$start_time[i], period_metrics$end_time[i])), linetype=4, color = "darkgreen")
	s <- s + scale_colour_brewer(palette="Set1", name="Usage") 
	s <- s + labs(x = "Timestamp", y = "Temperature", 
			title = sprintf("Raw temperature data for %s to %s", 
			strftime(as.POSIXct(period_metrics$start_time[i], origin = "1970-01-01")), 
			strftime(as.POSIXct(period_metrics$end_time[i], origin = "1970-01-01"))))
	#s <- s + scale_y_continuous(breaks=seq(0.0, max_outlet_temp + 10, 5))
	s <- s + theme(axis.text.x = element_text(angle = 90, hjust = 1))
	#print(s)

	#---------- Balloon plot of volume on flowrate vs time
	s <- ggplot(events[[i]], aes(start_time, mean_flowrate))
	s <- s + geom_point( aes(size=volume, color = type), show_guide=TRUE) 
	s <- s + scale_size("Usage volume", range = c(2, 20)) + scale_color_manual (values=c("steelblue2", "tomato"), name="Usage type")
	s <- s + geom_vline(xintercept = as.numeric(c(period_metrics$start_time[i], period_metrics$end_time[i])), linetype=4, color = "darkgreen")
	s <- s + geom_text(aes(x=start_time, y=mean_flowrate, label=sprintf("%5.1f",volume), size=2, vjust=-1))
	s <- s + geom_text(aes(x=start_time, y=mean_flowrate, label=sprintf("%5.1f deg",mean_temp_out), size=2, vjust=4))
	s <- s + geom_text(aes(x=start_time, y=mean_flowrate, label=sprintf("%5.1f deg",mean_temp_in), size=2, vjust=5))
	s <- s + labs(x = "Start time", y = "Flowrate [l/min]", title = "Balloon events volume [l] (on Flowrate vs Time)")
	#s <- s + scale_y_continuous(breaks=seq(0, max_flowrate, round(max_flowrate, -1)/10))
	#s <- s + scale_x_datetime(breaks = date_breaks(sprintf("%f hours", floor(period_metrics$time_dif_hours[i])/time_scale)), labels = date_format("%a %H:%M", tz = "GMT-2"))
	s <- s + theme(axis.text.x = element_text(angle = 90, hjust = 1))
	print(s)

}


dev.off()
