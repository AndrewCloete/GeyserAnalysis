read_daily_events <- function(date, geyser_id){

  input_path <- sprintf('~/Geyser/R/Daily/Output/events/%d/events_%s_%d.csv', geyser_id, date, geyser_id)

  events <- read.table(input_path, header=TRUE, sep=",")

  events$start_time <- as.POSIXct(strptime(events$start_time, "%Y-%m-%d %H:%M:%S"))

  return(events)
}
