source('~/Geyser/R/Batch/import_batch.r')
source('~/Geyser/R/Batch/View/plot_batch.r')





render_all_data_packet<- function(all_data){

  #Plot parameters
  time_scale <- 12
  plot_width <- 10
  legend <- TRUE

  s <- ggplot()
  s <- s + geom_line( aes(y=all_data[[1]]$packet_loss, x=as.Date(all_data[[1]]$date), color="104"), show_guide=legend)
  s <- s + geom_line( aes(y=all_data[[2]]$packet_loss, x=as.Date(all_data[[2]]$date), color="106"), show_guide=legend)
  s <- s + geom_line( aes(y=all_data[[3]]$packet_loss, x=as.Date(all_data[[3]]$date), color="107"), show_guide=legend)
  s <- s + geom_line( aes(y=all_data[[4]]$packet_loss, x=as.Date(all_data[[4]]$date), color="109"), show_guide=legend)
  s <- s + geom_line( aes(y=all_data[[5]]$packet_loss, x=as.Date(all_data[[5]]$date), color="110"), show_guide=legend)
  s <- s + geom_line( aes(y=all_data[[6]]$packet_loss, x=as.Date(all_data[[6]]$date), color="112"), show_guide=legend)

  s <- s + scale_colour_brewer(palette="Set1", name="Geyser ID")
  s <- s + labs(x = "Date", y = "Packet loss", title = "Packet loss")
  #s <- s + scale_y_continuous(breaks=seq(0.0, 100, 5))
  s <- s + scale_x_date(labels = date_format("%a %d %b", tz = "GMT-2"))
  s <- s + theme(axis.text.x = element_text(angle = 90, hjust = 1))

 return(s)
}

render_all_data_packet_avg<- function(all_data){

  #Plot parameters
  time_scale <- 12
  plot_width <- 10
  legend <- TRUE

  geyser_id <- list()
  avg_loss <- list()
  for(i in 1:length(all_data)){
      geyser_id[[i]] <- all_data[[i]]$geyser_id[1]
      avg_loss[[i]] <- mean(all_data[[i]]$packet_loss)
  }

}


geyser_ids = c(104, 106, 107, 109, 110, 112)
start_date = '2015-10-25'
end_date = '2015-10-31'
skip = as.Date(c('2015-09-25', '2015-09-26', '2015-11-01'))

all_data <- list()
for(i in 1:length(geyser_ids)){
  all_data[[i]] <- import_batch(geyser_ids[i], start_date, end_date, skip)
}


geyser_id <- list()
avg_loss <- list()
for(i in 1:length(all_data)){
    geyser_id[[i]] <- all_data[[i]]$geyser_id[1]
    avg_loss[[i]] <- mean(all_data[[i]]$packet_loss)
}

#  svg(file="~/test.svg", width=8, height=4)
  #print(s)
  #dev.off()
