library(ggplot2)
library(scales) # to access breaks/formatting functions

output_file <- sprintf("~/Geyser/R/Daily/geyser_%i_balloon.pdf", geyser_id)

#Plot parameters
time_scale <- 12
plot_width <- 20

#png(file=output_file, res = 120, width = 1000, height = 500)
#pdf(file=output_file, width=plot_width)
#par(mfrow=c(1,1))



all_minutes <- seq(start_time, end_time, by="min")
vlines <- subset(all_minutes, format(all_minutes, "%H:%M") == "02:00")

#---------- Balloon plot of volume on flowrate vs time
s <- ggplot(events, aes(start_time, mean_flowrate))
s <- s + geom_point( aes(size=volume, color = type), show_guide=TRUE)
s <- s + scale_size("Usage volume", range = c(2, 20)) + scale_color_manual (values=c("tomato"), name="Usage type")
s <- s + geom_vline(xintercept = as.numeric(vlines), linetype=4, color = "darkgreen")
#s <- s + geom_text(aes(x=start_time, y=mean_flowrate, label=sprintf(" %5.1f l",volume), size=10, vjust=0.5, hjust=-0.5))
s <- s + geom_text(aes(x=start_time, y=mean_flowrate, label=sprintf("%.1f", volume), size=5, vjust=-1, hjust=-0))
#s <- s + geom_text(aes(x=start_time, y=mean_flowrate, label=sprintf("%5.1f deg",mean_temp_in), size=2, vjust=5))
s <- s + labs(x = "Start time", y = "Flowrate [l/min]", title = "Events volume", limits = as.numeric(c(start_time, end_time)))
s <- s + scale_y_continuous(breaks=seq(0, max(events$mean_flowrate)+1, 1), limits=c(0, max(events$mean_flowrate)+1))
s <- s + scale_x_datetime(breaks = date_breaks(sprintf("%f hours", 1)), labels = date_format("%H:%M", tz = "GMT-2"))
s <- s + theme(axis.text.x = element_text(angle = 90, hjust = 1))
print(s)




#dev.off()
