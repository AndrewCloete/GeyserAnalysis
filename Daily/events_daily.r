source('~/Geyser/R/event_detector.r')

events_daily <- function(data){

  events <- extract_hot_events(data, 0.1, 0.1)

  return(events)
}
