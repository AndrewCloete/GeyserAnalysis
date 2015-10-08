
events_beautify <- function(events){
  display <- events[,!(names(events) %in% c("type", "mean_temp_in", "mean_flowrate"))]

  display$enthalpy <- display$enthalpy/(1000*3600)
  display$start_time <- as.character(display$start_time, format="%H:%M:%S")
  display$est_cost <- display$enthalpy*1.5

  colnames(display) <- c("Start time", "Volume (l)","Duration", "Avg temperature", "Est energy (kWh)", "Est cost (R)")


  return(display)
}
