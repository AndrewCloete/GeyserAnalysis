library(scatterplot3d)
library(ggplot2)
library(scales) # to access breaks/formatting functions

# --------------------------------------- Plot ------------------------------------------------------ #
# NB! The "color" parameter in geom_line specifies the LABEL and NOT the actual color.

output_file <- sprintf("~/Geyser/Plots/Merge/geyser_%i.pdf", geyser_id)

#Plot parameters
time_scale <- 48
plot_width <- 20

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
s <- s + geom_line( aes(y=geyser_data$t1, x=data_serverstamp, color="Outlet"), show_guide=TRUE) 
s <- s + geom_line( aes(y=geyser_data$t2, x=data_serverstamp, color="Far"), show_guide=TRUE) 
s <- s + geom_line( aes(y=geyser_data$t3, x=data_serverstamp, color="Inlet"), show_guide=TRUE) 
s <- s + geom_line( aes(y=geyser_data$t4, x=data_serverstamp, color="Abmient"), show_guide=TRUE) 
s <- s + geom_line( aes(y=geyser_data$watt_avgpmin, x=data_serverstamp, color = "Power"), show_guide=TRUE) 
s <- s + geom_vline(xintercept = as.numeric(midnights), linetype=4, color = "darkgreen")
s <- s + scale_colour_brewer(palette="Set1", name="Usage") 
s <- s + labs(x = "Timestamp", y = "Temperature", title = "Raw data")
s <- s + scale_y_continuous(breaks=seq(0.0, max_outlet_temp + 10, 5))
s <- s + theme(axis.text.x = element_text(angle = 90, hjust = 1))
print(s)

#---------- Line plot of accumulative volume
s <- ggplot(geyser_data)
s <- s + geom_line( aes(y=geyser_data$hot_litres_tot, x=data_serverstamp, color="Hot"), show_guide=TRUE) 
s <- s + geom_line( aes(y=geyser_data$cold_litres_tot, x=data_serverstamp, color="Cold"), show_guide=TRUE) 
s <- s + geom_vline(xintercept = as.numeric(midnights), linetype=4, color = "darkgreen")
s <- s + scale_color_manual (values=c("steelblue2", "tomato"), name="Usage type")
s <- s + labs(x = "Timestamp", y = "Volume [litres]", title = "Accumulative flow")
s <- s + scale_y_continuous(breaks=seq(0.0, max_acc_volume + 10, round(max_acc_volume/20, -1)))
s <- s + theme(axis.text.x = element_text(angle = 90, hjust = 1))
print(s)

#---------- Balloon plot of volume on flowrate vs time
s <- ggplot(events, aes(events$start_time, events$mean_flowrate))
s <- s + geom_vline(xintercept = as.numeric(midnights), linetype=4, color = "darkgreen")
s <- s + geom_point( aes(size=events$volume, color = events$pcol), show_guide=TRUE) 
s <- s + scale_size("Usage volume", range = c(2, 20)) + scale_color_manual (values=c("steelblue2", "tomato"), name="Usage type")
s <- s + geom_text(aes(x=events$start_time, y=events$mean_flowrate, label=sprintf("%5.1f",events$volume), size=2, vjust=-1))
s <- s + labs(x = "Start time", y = "Flowrate [l/min]", title = "Balloon events volume [l] (on Flowrate vs Time)")
s <- s + scale_y_continuous(breaks=seq(0, max_flowrate, round(max_flowrate, -1)/10))
s <- s + scale_x_datetime(breaks = date_breaks(sprintf("%f hours", floor(time_dif_hours)/time_scale)), labels = date_format("%a %H:%M", tz = "GMT-2"))
s <- s + theme(axis.text.x = element_text(angle = 90, hjust = 1))
print(s)

#--------- Balloon plot of volume on duration vs time
s <- ggplot(events, aes(events$start_time, events$duration))
s <- s + geom_vline(xintercept = as.numeric(midnights), linetype=4, color = "darkgreen")
s <- s + geom_point( aes(size=events$volume, color = events$pcol), show_guide=TRUE) 
s <- s + scale_size("Usage volume", range = c(2, 20)) + scale_color_manual (values=c("steelblue2", "tomato"), name="Usage type")
s <- s + geom_text(aes(x=events$start_time, y=events$duration, label=sprintf("%5.1f",events$volume), size=2, vjust=-1))
s <- s + labs(x = "Start time", y = "Duration [min]", title = "Balloon events volume [l] (on Duration vs Time)")
s <- s + scale_y_continuous(breaks=seq(0, max_duration+10, round(max_duration, -1)/10))
s <- s + scale_x_datetime(breaks = date_breaks(sprintf("%f hours", floor(time_dif_hours)/time_scale)), labels = date_format("%a %H:%M", tz = "GMT-2"))
s <- s + theme(axis.text.x = element_text(angle = 90, hjust = 1))
print(s)


#---------- Balloon plot of duration on volume vs time
s <- ggplot(events, aes(events$start_time, events$volume))
s <- s + geom_vline(xintercept = as.numeric(midnights), linetype=4, color = "darkgreen")
s <- s + geom_point( aes(size=events$duration, color = events$pcol), show_guide=TRUE) 
s <- s + scale_size("Usage volume", range = c(2, 20)) + scale_color_manual (values=c("steelblue2", "tomato"), name="Usage type")
s <- s + geom_text(aes(x=events$start_time, y=events$volume, label=sprintf("%5.1f", events$duration), size=2, vjust=-1))
s <- s + labs(x = "Start time", y = "Volume [litres]", title = "Balloon events duration [min] (on Volume vs Time)")
s <- s + scale_y_continuous(breaks=seq(0, max_volume+10, round(max_volume/5, -1)))
s <- s + scale_x_datetime(breaks = date_breaks(sprintf("%f hours", floor(time_dif_hours)/time_scale)), labels = date_format("%a %H:%M", tz = "GMT-2"))
s <- s + theme(axis.text.x = element_text(angle = 90, hjust = 1))
print(s)

#---------- Balloon plot of flowrate on volume vs duration
s <- ggplot(events, aes(events$duration, events$volume))
s <- s + geom_point( aes(size=events$mean_flowrate, color = events$pcol), show_guide=TRUE) 
s <- s + scale_size("Usage volume", range = c(2, 20)) + scale_color_manual (values=c("steelblue2", "tomato"), name="Usage type")
s <- s + geom_text(aes(x=events$duration, y=events$volume, label=sprintf("%5.1f", events$mean_flowrate), size=1, vjust=-1))
s <- s + labs(x = "Duration [min]", y = "Volume [litres]", title = "Balloon events flowrate [l/min] (on Volume vs Duration)")
s <- s + scale_y_continuous(breaks=seq(0, max_volume+10, round(max_volume/5, -1)))
s <- s + scale_x_continuous(breaks=seq(0, max_duration+10, round(max_duration, -1)/10))
print(s)
# ---------------------------------------------------------------------------------------------------- #

print(sprintf("Plotting to ~/Geyser/Plots/Merge/geyser_%i.pdf", geyser_id))
dev.off()

