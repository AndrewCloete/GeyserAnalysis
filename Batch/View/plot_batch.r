library(ggplot2)
library(scales) # to access breaks/formatting functions

plot_batch_volume <- function(batch_summary){

  s <- ggplot(batch_summary, aes(x=date, y=factor(total_volume)))
  s <- s + geom_bar(stat="identity")
  s <- s + labs(x = "Date", y = "Volume [l]", title = "Water usage per day")
  s <- s + scale_x_datetime(breaks = date_breaks(sprintf("%f days", 1)), labels = date_format("%a %d %b", tz = "GMT-2"))
  s <- s + theme(axis.text.x = element_text(angle = 90, hjust = 1))
  print(s)

}

plot_batch_energy <- function(batch_summary){
  s <- ggplot(batch_summary)
  s <- s + geom_bar(aes(y=total_elec_energy, x=date, fill="Electrical"), stat="identity")
  s <- s + geom_bar(aes(y=total_enthalpy, x=date, fill="Effective"), stat="identity")
  s <- s + geom_bar(aes(y=energy_loss, x=date, fill="Loss"), stat="identity")
  s <- s + scale_fill_manual(values=c("yellowgreen","darkorchid", "gray29"), name="Type")
  s <- s + labs(x = "Date", y = "Energy [kWh]", title = "Total energy usage per day")
  s <- s + scale_x_datetime(breaks = date_breaks(sprintf("%f days", 1)), labels = date_format("%a %d %b", tz = "GMT-2"))
  s <- s + theme(axis.text.x = element_text(angle = 90, hjust = 1))
  print(s)
}


plot_batch_cost <- function(batch_summary){
  s <- ggplot(batch_summary)
  s <- s + geom_bar(aes(y=est_cost, x=date), stat="identity")
  s <- s + labs(x = "Date", y = "Cost [R]", title = "Cost per day")
  s <- s + scale_x_datetime(breaks = date_breaks(sprintf("%f days", 1)), labels = date_format("%a %d %b", tz = "GMT-2"))
  s <- s + theme(axis.text.x = element_text(angle = 90, hjust = 1))
  print(s)
}


plot_batch_temperature <- function(batch_summary){
  s <- ggplot(batch_summary)
  s <- s + geom_line(aes(y=t_out_max, x=date, color="Max outlet"))
  s <- s + geom_line(aes(y=t_out_mean, x=date, color="Avg outlet"))
  s <- s + geom_line(aes(y=t_amb_mean, x=date, color="Avg ambient"))
  s <- s + scale_colour_brewer(palette="Set1", name="Usage")
  s <- s + labs(x = "Date", y = "Temperature [degC]", title = "Temperature summary")
  s <- s + scale_y_continuous(breaks=seq(0.0, max(batch_summary$t_out_max) + 10, 5), limits=c(0, max(batch_summary$t_out_max)))
  s <- s + scale_x_datetime(breaks = date_breaks(sprintf("%f days", 1)), labels = date_format("%a %d %b", tz = "GMT-2"))
  s <- s + theme(axis.text.x = element_text(angle = 90, hjust = 1))
  print(s)
}


max_volume_tick <- function(max){
  if(max <= 50 )
    max <- 50
  else if(max <= 50 && max >= 100)
    max <- 100
  else if(max <= 100 && max >= 200)
    max <- 200
  else if(max <= 200 && max >= 300)
    max <- 300
  else if(max <= 300 && max >= 400)
    max <- 400
  else if(max <= 400 && max >= 500)
    max <- 500
  else if(max <= 500 && max >= 600)
    max <- 600
  else if(max <= 600 && max >= 700)
    max <- 700
  else if(max <= 700 && max >= 800)
    max <- 800
  else if(max <= 800 && max >= 900)
    max <- 900

  return(max)

}
