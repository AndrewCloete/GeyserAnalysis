source('~/Geyser/R/Daily/import_daily.r')
source('~/Geyser/R/event_detector.r')

analyse_daily <- function(data, events){

      geyser_id <- data$geyser_id[1]
      date <- as.Date(data$server_stamp[1])

      event_midpoint <- 10
      upper_events <- subset(events, volume>=event_midpoint)
      lower_events <- subset(events, volume<event_midpoint)

      # ---------------------------------------------------------------------------- #
      total_volume <- round(sum(data$hot_flow_dif), 1)
      total_elec_energy <- round(sum(data$kwatt_dif), 1)
      total_enthalpy <- round(sum(events$enthalpy), 1)
      est_cost <- round(total_elec_energy*1.5, 2)
      energy_loss <- round(total_elec_energy-total_enthalpy, 1)
      percent_loss <- round((energy_loss/total_elec_energy)*100, 1)

      t_out_min <- min(data$t1)
      t_in_min <- min(data$t3)
      t_amb_min <- min(data$t4)

      t_out_mean <- round(mean(data$t1), 0)
      t_in_mean <- round(mean(data$t3), 0)
      t_amb_mean <- round(mean(data$t4), 0)

      t_out_max <- max(data$t1)
      t_in_max <- max(data$t3)
      t_amb_max <- max(data$t4)

      total_events_count <- length(events[,1])
      upper_events_count <- length(upper_events[,1])
      lower_events_count <- length(lower_events[,1])

      num_samples <- length(data[,1])
      packet_loss <- round(100 - (num_samples/1440)*100, 2)

      summary <- data.frame(date, geyser_id,
                            total_volume,
                            total_elec_energy, total_enthalpy, est_cost, energy_loss, percent_loss,
                            t_out_min, t_out_mean, t_out_max,
                            t_in_min, t_in_mean, t_in_max,
                            t_amb_min, t_amb_mean, t_amb_max,
                            total_events_count, upper_events_count, lower_events_count, event_midpoint,
                            num_samples, packet_loss
                            )

      return(summary)
}


#output_path <- sprintf('~/Geyser/R/Daily/Output/%d/%s_%d.csv', geyser_id, date, geyser_id)
#write.table(summary, file = output_path, append = FALSE, quote = TRUE, sep = ",",
#            eol = "\n", na = "NA", dec = ".", row.names = FALSE,
#            col.names = TRUE, qmethod = c("escape", "double"),
#            fileEncoding = "")
