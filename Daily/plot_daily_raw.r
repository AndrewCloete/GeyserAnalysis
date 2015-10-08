library(ggplot2)
library(scales) # to access breaks/formatting functions

#output_file <- sprintf("~/Geyser/R/Daily/geyser_%i_raw.pdf", geyser_id)

#Plot parameters
time_scale <- 12
plot_width <- 20

#png(file=output_file, res = 120, width = 1000, height = 500)
#pdf(file=output_file, width=plot_width)
#par(mfrow=c(1,1))

start_time = as.POSIXct(strptime(sprintf("%s 02:00:00", date), "%Y-%m-%d %H:%M:%S"))
end_time = start_time + 24*60*60

all_minutes <- seq(start_time, end_time, by="min")
vlines <- subset(all_minutes, format(all_minutes, "%H:%M") == "02:00")

s <- ggplot(data)
s <- s + geom_line( aes(y=t1, x=server_stamp, color="Outlet"), show_guide=TRUE)
s <- s + geom_line( aes(y=t2, x=server_stamp, color="Far"), show_guide=TRUE)
s <- s + geom_line( aes(y=t3, x=server_stamp, color="Inlet"), show_guide=TRUE)
s <- s + geom_line( aes(y=t4, x=server_stamp, color="Abmient"), show_guide=TRUE)
s <- s + geom_line( aes(y=watt_avgpmin, x=server_stamp, color = "Power"), show_guide=TRUE)
s <- s + geom_vline(xintercept = as.numeric(vlines), linetype=4, color = "darkgreen")
s <- s + scale_colour_brewer(palette="Set1", name="Usage")
s <- s + labs(x = "Timestamp", y = "Temperature", title = sprintf("Raw data for %s", as.Date(end_time)))
#s <- s + scale_y_continuous(breaks=seq(0.0, max_outlet_temp + 10, 5))
s <- s + scale_x_datetime(breaks = date_breaks(sprintf("%f hours", 1)), labels = date_format("%H:%M", tz = "GMT-2"))
s <- s + theme(axis.text.x = element_text(angle = 90, hjust = 1))
print(s)

#dev.off()
