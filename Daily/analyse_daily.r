source('~/Geyser/R/event_detector.r')


# ----------------  Differentiate acc volume to get flow   ------------------- #
data$hot_flow_dif <- dif(data$hot_litres_tot)
data$kwatt_dif <- dif(data$kwatt_tot)
# ---------------------------------------------------------------------------- #

event_midpoint <- 10
events <- extract_hot_events(data, 0.1, 0.1)
upper_events <- subset(events, volume>=event_midpoint)
lower_events <- subset(events, volume<event_midpoint)


# ---------------------------------------------------------------------------- #
total_volume <- sum(data$hot_flow_dif)
total_elec_energy <- sum(data$kwatt_dif)
total_enthalpy <- sum(events$enthalpy)/(1000*3600)
energy_loss <- total_elec_energy-total_enthalpy

t_out_min <- min(data$t1)
t_in_min <- min(data$t3)
t_amb_min <- min(data$t4)

t_out_mean <- mean(data$t1)
t_in_mean <- mean(data$t3)
t_amb_mean <- mean(data$t4)

t_out_max <- max(data$t1)
t_in_max <- max(data$t3)
t_amb_max <- max(data$t4)

total_events_count <- length(events[,1])
upper_events_count <- length(upper_events[,1])
lower_events_count <- length(lower_events[,1])

num_samples <- length(data[,1])
packet_loss <- 100 - (num_samples/1440)*100

summary <- data.frame(date, geyser_id,
                      total_volume,
                      total_elec_energy, total_enthalpy, energy_loss,
                      t_out_min, t_out_mean, t_out_max,
                      t_in_min, t_in_mean, t_in_max,
                      t_amb_min, t_amb_mean, t_amb_max,
                      total_events_count, upper_events_count, lower_events_count, event_midpoint,
                      num_samples, packet_loss
                      )
#print(summary)


#write.table(summary, file = output_path, append = FALSE, quote = TRUE, sep = ",",
#            eol = "\n", na = "NA", dec = ".", row.names = FALSE,
#            col.names = TRUE, qmethod = c("escape", "double"),
#            fileEncoding = "")
