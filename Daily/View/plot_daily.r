library(ggplot2)
library(scales) # to access breaks/formatting functions


tofile_daily <- function(image, root_folder, geyser_id, date, name, format){

  output_file <- sprintf("%s/%i/%i_%s_%s.%s", root_folder, geyser_id, geyser_id, date, name, format)
  #output_file <- sprintf("~/Geyser/Plots/RawDaily/%i/%i_%s_raw.svg", geyser_id, geyser_id, date)

  if(identical(format, "svg")){
    svg(file=output_file, width=8, height=4)
  }
  else if(identical(format, "pdf")){
    pdf(file=output_file, width=15)
  }
  else{
    png(file=output_file, res = 120, width = 1000, height = 500)
  }
  par(mfrow=c(1,1))

  print(image)

  dev.off()
}

render_daily_raw <- function(data){

  #Plot parameters
  time_scale <- 12
  plot_width <- 10
  legend <- TRUE
  geyser_id <- data[1,2]
  date <- as.Date(data$server_stamp[1])

  start_time = as.POSIXct(strptime(sprintf("%s 02:00:00", date), "%Y-%m-%d %H:%M:%S"))
  end_time = start_time + 24*60*60

  all_minutes <- seq(start_time, end_time, by="min")
  vlines <- subset(all_minutes, format(all_minutes, "%H:%M") == "02:00")

  s <- ggplot(data)
  s <- s + geom_line( aes(y=t1, x=server_stamp, color="Outlet"), show_guide=legend)
  s <- s + geom_line( aes(y=t2, x=server_stamp, color="Far"), show_guide=legend)
  s <- s + geom_line( aes(y=t3, x=server_stamp, color="Inlet"), show_guide=legend)
  s <- s + geom_line( aes(y=t4, x=server_stamp, color="Abmient"), show_guide=legend)
  s <- s + geom_line( aes(y=watt_avgpmin, x=server_stamp, color = "Power"), show_guide=legend)
  s <- s + geom_vline(xintercept = as.numeric(vlines), linetype=4, color = "darkgreen")
  s <- s + scale_colour_brewer(palette="Set1", name="Usage")
  s <- s + labs(x = "Timestamp", y = "Temperature", title = sprintf("Raw data for %s", as.Date(start_time)))
  #s <- s + scale_y_continuous(breaks=seq(0.0, max_outlet_temp + 10, 5))
  s <- s + scale_x_datetime(breaks = date_breaks(sprintf("%f hours", 1)), labels = date_format("%H:%M", tz = "GMT-2"))
  s <- s + theme(axis.text.x = element_text(angle = 90, hjust = 1))

 return(s)
}

render_daily_raw_flow <- function(data){

  #Plot parameters
  time_scale <- 12
  plot_width <- 10
  geyser_id <- data[1,2]
  date <- as.Date(data$server_stamp[1])

  start_time = as.POSIXct(strptime(sprintf("%s 02:00:00", date), "%Y-%m-%d %H:%M:%S"))
  end_time = start_time + 24*60*60

  all_minutes <- seq(start_time, end_time, by="min")
  vlines <- subset(all_minutes, format(all_minutes, "%H:%M") == "02:00")

  s <- ggplot(data)
  s <- s + geom_line( aes(y=hot_litres_tot, x=server_stamp))
  s <- s + geom_vline(xintercept = as.numeric(vlines), linetype=4, color = "darkgreen")
  s <- s + scale_colour_brewer(palette="Set1", name="Volume")
  s <- s + labs(x = "Timestamp", y = "Volume", title = sprintf("Raw data for %s", as.Date(start_time)))
  #s <- s + scale_y_continuous(breaks=seq(0.0, max_outlet_temp + 10, 5))
  s <- s + scale_x_datetime(breaks = date_breaks(sprintf("%f hours", 1)), labels = date_format("%H:%M", tz = "GMT-2"))
  s <- s + theme(axis.text.x = element_text(angle = 90, hjust = 1))

  return(s)
}


render_daily_balloon <- function(date, events){

  #Plot parameters
  time_scale <- 12
  plot_width <- 10
  legend <- TRUE
  geyser_id <- data[1,2]
  #date passed as paramenter

  start_t = as.POSIXct(strptime(sprintf("%s 02:00:00", date), "%Y-%m-%d %H:%M:%S"))
  end_t = start_t + 24*60*60

  all_minutes <- seq(start_t, end_t, by="min")
  vlines <- subset(all_minutes, format(all_minutes, "%H:%M") == "02:00")

  #---------- Balloon plot of volume on flowrate vs time
  s <- ggplot(events, aes(events$start_time, events$mean_flowrate))
  s <- s + geom_point( aes(size=volume, color = type), show_guide=legend)
  s <- s + scale_size("Usage volume", range = c(2, 20)) + scale_color_manual (values=c("tomato"), name="Usage type")
  s <- s + geom_vline(xintercept = as.numeric(vlines), linetype=4, color = "darkgreen")
  #s <- s + geom_text(aes(x=start_time, y=mean_flowrate, label=sprintf(" %5.1f l",volume), size=10, vjust=0.5, hjust=-0.5))
  s <- s + geom_text(aes(x=start_time, y=mean_flowrate, label=sprintf("R%.1f", enthalpy*1.5), size=(max(events$mean_flowrate)/2), vjust=-1, hjust=-0), show_guide=FALSE)
  #s <- s + geom_text(aes(x=start_time, y=mean_flowrate, label=sprintf("%5.1f deg",mean_temp_in), size=2, vjust=5))
  s <- s + labs(x = "Start time", y = "Flowrate [l/min]", title = "Volume [l]", limits = as.numeric(c(start_t, end_t)))
  s <- s + scale_y_continuous(breaks=seq(0, max(events$mean_flowrate)+1, 1), limits=c(0, max(events$mean_flowrate)+1))
  s <- s + scale_x_datetime(breaks = date_breaks(sprintf("%f hours", 1)), labels = date_format("%H:%M", tz = "GMT-2"))
  s <- s + theme(axis.text.x = element_text(angle = 90, hjust = 1))

  return(s)
}
