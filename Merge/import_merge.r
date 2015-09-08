geyser_id <- 109

sim_filename <- sprintf("~/Geyser/SimulatorOutput/result_%i.csv", geyser_id)
data_filename <- sprintf("~/Geyser/SimulatorOutput/data_%i.csv", geyser_id)

sim_results <- read.table(sim_filename, header=TRUE, 
  	sep=",")

geyser_data <- read.table(data_filename, header=TRUE, 
  	sep=",")

data_serverstamp <- as.POSIXct(strptime(geyser_data$server_stamp, "%Y-%m-%d %H:%M:%S"))
sim_timestamp <- as.POSIXct(strptime(sim_results$timestamp, "%Y-%m-%d %H:%M:%S"))
