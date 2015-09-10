library(ggplot2)
library(scales) # to access breaks/formatting functions

# --------------------------------------- Plot ------------------------------------------------------ #
# NB! The "color" parameter in geom_line specifies the LABEL and NOT the actual color.

output_file <- sprintf("~/Geyser/Plots/Merge/geyser_%i.pdf", geyser_id)

#Plot parameters
time_scale <- 12
plot_width <- 15

#bmp(file=sprintf("Plot_%s.bmp", args[1]))#, quality = 100, width = 1000, height = 1000)
pdf(file=output_file, width=plot_width)
par(mfrow=c(1,1))

#---------- Point plot of network performance
s <- ggplot()
s <- s + geom_point( aes(x=as.POSIXct(server_stamp_diff$start_time, origin="1970-01-01"), y=server_stamp_diff$diff, color="Server", size=2), shape = 18,show_guide=TRUE)
s <- s + geom_point( aes(x=as.POSIXct(client_stamp_diff$start_time, origin="1970-01-01"), y=client_stamp_diff$diff, color="Client"), show_guide=TRUE)
s <- s + geom_vline(xintercept = as.numeric(midnights), linetype=4, color = "darkgreen")
s <- s + scale_color_manual (values=c("gold2", "darkorchid3"), name="Timestamp") + scale_shape_discrete(solid=T, guide="none") + scale_size(guide="none")
s <- s + labs(x = "Start timestamp", y = "Delay [minutes]", title = "Comms performance: Timestamp delay")
s <- s + scale_x_datetime(breaks = date_breaks(sprintf("%f hours", floor(time_dif_hours)/time_scale)), labels = date_format("%a %H:%M", tz = "GMT-2"))
s <- s + theme(axis.text.x = element_text(angle = 90, hjust = 1))
print(s)		


#---------- Line plot of temperatures
s <- ggplot(geyser_data)
s <- s + geom_line( aes(y=t1, x=server_stamp, color="Outlet"), show_guide=TRUE) 
s <- s + geom_line( aes(y=t2, x=server_stamp, color="Far"), show_guide=TRUE) 
s <- s + geom_line( aes(y=t3, x=server_stamp, color="Inlet"), show_guide=TRUE) 
s <- s + geom_line( aes(y=t4, x=server_stamp, color="Abmient"), show_guide=TRUE) 
s <- s + geom_line( aes(y=watt_avgpmin, x=server_stamp, color = "Power"), show_guide=TRUE) 
s <- s + geom_vline(xintercept = as.numeric(midnights), linetype=4, color = "darkgreen")
s <- s + scale_colour_brewer(palette="Set1", name="Usage") 
s <- s + labs(x = "Timestamp", y = "Temperature", title = "Raw temperature data")
s <- s + scale_y_continuous(breaks=seq(0.0, max_outlet_temp + 10, 5))
s <- s + theme(axis.text.x = element_text(angle = 90, hjust = 1))
print(s)

#---------- Line plot of accumulative volume
s <- ggplot(geyser_data)
s <- s + geom_line( aes(y=hot_litres_tot, x=server_stamp, color="Hot"), show_guide=TRUE) 
s <- s + geom_line( aes(y=cold_litres_tot, x=server_stamp, color="Cold"), show_guide=TRUE) 
s <- s + geom_vline(xintercept = as.numeric(midnights), linetype=4, color = "darkgreen")
s <- s + scale_color_manual (values=c("steelblue2", "tomato"), name="Usage type")
s <- s + labs(x = "Timestamp", y = "Volume [litres]", title = "Accumulative flow per day (reset at 02:00)")
s <- s + scale_y_continuous(breaks=seq(0.0, max_acc_volume + 10, round(max_acc_volume/20, -1)))
s <- s + theme(axis.text.x = element_text(angle = 90, hjust = 1))
print(s)

#---------- Balloon plot of volume on flowrate vs time
s <- ggplot(events, aes(start_time, mean_flowrate))
s <- s + geom_vline(xintercept = as.numeric(midnights), linetype=4, color = "darkgreen")
s <- s + geom_point( aes(size=volume, color = pcol), show_guide=TRUE) 
s <- s + scale_size("Usage volume", range = c(2, 20)) + scale_color_manual (values=c("steelblue2", "tomato"), name="Usage type")
s <- s + geom_text(aes(x=start_time, y=mean_flowrate, label=sprintf("%5.1f",volume), size=2, vjust=-1))
s <- s + labs(x = "Start time", y = "Flowrate [l/min]", title = "Balloon events volume [l] (on Flowrate vs Time)")
s <- s + scale_y_continuous(breaks=seq(0, max_flowrate, round(max_flowrate, -1)/10))
s <- s + scale_x_datetime(breaks = date_breaks(sprintf("%f hours", floor(time_dif_hours)/time_scale)), labels = date_format("%a %H:%M", tz = "GMT-2"))
s <- s + theme(axis.text.x = element_text(angle = 90, hjust = 1))
print(s)

#--------- Balloon plot of volume on duration vs time
s <- ggplot(events, aes(start_time, duration))
s <- s + geom_vline(xintercept = as.numeric(midnights), linetype=4, color = "darkgreen")
s <- s + geom_point( aes(size=volume, color = pcol), show_guide=TRUE) 
s <- s + scale_size("Usage volume", range = c(2, 20)) + scale_color_manual (values=c("steelblue2", "tomato"), name="Usage type")
s <- s + geom_text(aes(x=start_time, y=duration, label=sprintf("%5.1f", volume), size=2, vjust=-1))
s <- s + labs(x = "Start time", y = "Duration [min]", title = "Balloon events volume [l] (on Duration vs Time)")
s <- s + scale_y_continuous(breaks=seq(0, max_duration+10, round(max_duration, -1)/10))
s <- s + scale_x_datetime(breaks = date_breaks(sprintf("%f hours", floor(time_dif_hours)/time_scale)), labels = date_format("%a %H:%M", tz = "GMT-2"))
s <- s + theme(axis.text.x = element_text(angle = 90, hjust = 1))
print(s)


#---------- Balloon plot of duration on volume vs time
s <- ggplot(events, aes(start_time, volume))
s <- s + geom_vline(xintercept = as.numeric(midnights), linetype=4, color = "darkgreen")
s <- s + geom_point( aes(size=duration, color = pcol), show_guide=TRUE) 
s <- s + scale_size("Usage volume", range = c(2, 20)) + scale_color_manual (values=c("steelblue2", "tomato"), name="Usage type")
s <- s + geom_text(aes(x=start_time, y=volume, label=sprintf("%5.1f", duration), size=2, vjust=-1))
s <- s + labs(x = "Start time", y = "Volume [litres]", title = "Balloon events duration [min] (on Volume vs Time)")
s <- s + scale_y_continuous(breaks=seq(0, max_volume+10, round(max_volume/5, -1)))
s <- s + scale_x_datetime(breaks = date_breaks(sprintf("%f hours", floor(time_dif_hours)/time_scale)), labels = date_format("%a %H:%M", tz = "GMT-2"))
s <- s + theme(axis.text.x = element_text(angle = 90, hjust = 1))
print(s)

#---------- Balloon plot of flowrate on volume vs duration
s <- ggplot(events, aes(duration, volume))
s <- s + geom_point( aes(size=mean_flowrate, color = pcol), show_guide=TRUE) 
s <- s + scale_size("Usage volume", range = c(2, 20)) + scale_color_manual (values=c("steelblue2", "tomato"), name="Usage type")
s <- s + geom_text(aes(x=duration, y=volume, label=sprintf("%5.1f", mean_flowrate), size=1, vjust=-1))
s <- s + labs(x = "Duration [min]", y = "Volume [litres]", title = "Balloon events flowrate [l/min] (on Volume vs Duration)")
s <- s + scale_y_continuous(breaks=seq(0, max_volume+10, round(max_volume/5, -1)))
s <- s + scale_x_continuous(breaks=seq(0, max_duration+10, round(max_duration, -1)/10))
print(s)
# ---------------------------------------------------------------------------------------------------- #

print(sprintf("Plotting to ~/Geyser/Plots/Merge/geyser_%i.pdf", geyser_id))
dev.off()

