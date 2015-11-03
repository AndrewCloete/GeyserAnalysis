library(ggplot2)
library(scales) # to access breaks/formatting functions

tofile_batch <- function(image, root_folder, geyser_id, date, name, format){

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



render_batch_volume <- function(batch_summary){

  s <- ggplot(batch_summary, aes(x=date, y=factor(total_volume)))
  s <- s + geom_bar(stat="identity")
  s <- s + labs(x = "Date", y = "Volume [l]", title = "Water usage per day")
  s <- s + scale_x_datetime(breaks = date_breaks(sprintf("%f days", 1)), labels = date_format("%a %d %b", tz = "GMT-2"))
  s <- s + theme(axis.text.x = element_text(angle = 90, hjust = 1))

  return(s)
}

render_batch_energy <- function(batch_summary){
  s <- ggplot(batch_summary)
  s <- s + geom_bar(aes(y=total_elec_energy, x=date, fill="Electrical"), stat="identity")
  s <- s + geom_bar(aes(y=total_enthalpy, x=date, fill="Effective"), stat="identity")
  s <- s + geom_bar(aes(y=energy_loss, x=date, fill="Loss"), stat="identity")
  s <- s + scale_fill_manual(values=c("yellowgreen","darkorchid", "gray29"), name="Type")
  s <- s + labs(x = "Date", y = "Energy [kWh]", title = "Total energy usage per day")
  #s <- s + scale_x_datetime(breaks = date_breaks(sprintf("%f days", 1)), labels = date_format("%a %d %b", tz = "GMT-2"))
  s <- s + theme(axis.text.x = element_text(angle = 90, hjust = 1))

  return(s)
}


render_batch_cost <- function(batch_summary){
  s <- ggplot(batch_summary)
  s <- s + geom_bar(aes(y=est_cost, x=date), stat="identity")
  s <- s + labs(x = "Date", y = "Cost [R]", title = "Cost per day")
  s <- s + scale_x_datetime(breaks = date_breaks(sprintf("%f days", 1)), labels = date_format("%a %d %b", tz = "GMT-2"))
  s <- s + theme(axis.text.x = element_text(angle = 90, hjust = 1))

  return(s)
}


render_batch_temperature <- function(batch_summary){
  s <- ggplot(batch_summary)
  s <- s + geom_line(aes(y=t_out_max, x=date, color="Max outlet"))
  s <- s + geom_line(aes(y=t_out_mean, x=date, color="Avg outlet"))
  s <- s + geom_line(aes(y=t_amb_mean, x=date, color="Avg ambient"))
  s <- s + scale_colour_brewer(palette="Set1", name="Usage")
  s <- s + labs(x = "Date", y = "Temperature [degC]", title = "Temperature summary")
  s <- s + scale_y_continuous(breaks=seq(0.0, max(batch_summary$t_out_max) + 10, 5), limits=c(0, max(batch_summary$t_out_max)))
  s <- s + scale_x_datetime(breaks = date_breaks(sprintf("%f days", 1)), labels = date_format("%a %d %b", tz = "GMT-2"))
  s <- s + theme(axis.text.x = element_text(angle = 90, hjust = 1))

  return(s)
}
