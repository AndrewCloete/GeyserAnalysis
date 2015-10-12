library(ggplot2)
library(scales) # to access breaks/formatting functions

plot_daily_balloon <- function(date, events, tofile){

#Plot parameters
time_scale <- 12
plot_width <- 20

if(tofile){
  output_file <- sprintf("~/Geyser/R/Daily/geyser_%i_balloon.pdf", 0)
  #png(file=output_file, res = 120, width = 1000, height = 500)
  pdf(file=output_file, width=plot_width)
  par(mfrow=c(1,1))
}

start_t = as.POSIXct(strptime(sprintf("%s 02:00:00", date), "%Y-%m-%d %H:%M:%S"))
end_t = start_t + 24*60*60

all_minutes <- seq(start_t, end_t, by="min")
vlines <- subset(all_minutes, format(all_minutes, "%H:%M") == "02:00")

#---------- Balloon plot of volume on flowrate vs time
s <- ggplot(events, aes(events$start_time, events$mean_flowrate))
s <- s + geom_point( aes(size=volume, color = type), show_guide=TRUE)
s <- s + scale_size("Usage volume", range = c(2, 20)) + scale_color_manual (values=c("tomato"), name="Usage type")
s <- s + geom_vline(xintercept = as.numeric(vlines), linetype=4, color = "darkgreen")
#s <- s + geom_text(aes(x=start_time, y=mean_flowrate, label=sprintf(" %5.1f l",volume), size=10, vjust=0.5, hjust=-0.5))
s <- s + geom_text(aes(x=start_time, y=mean_flowrate, label=sprintf("R%.1f", enthalpy*1.5), size=(max(events$mean_flowrate)/2), vjust=-1, hjust=-0))
#s <- s + geom_text(aes(x=start_time, y=mean_flowrate, label=sprintf("%5.1f deg",mean_temp_in), size=2, vjust=5))
s <- s + labs(x = "Start time", y = "Flowrate [l/min]", title = "Volume [l]", limits = as.numeric(c(start_t, end_t)))
s <- s + scale_y_continuous(breaks=seq(0, max(events$mean_flowrate)+1, 1), limits=c(0, max(events$mean_flowrate)+1))
s <- s + scale_x_datetime(breaks = date_breaks(sprintf("%f hours", 1)), labels = date_format("%H:%M", tz = "GMT-2"))
s <- s + theme(axis.text.x = element_text(angle = 90, hjust = 1))
print(s)

if(tofile){
  dev.off()
}

}
