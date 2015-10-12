geyser_id = 107

input_path <- sprintf('~/Geyser/R/Batch/Output/%d_*.csv', geyser_id)
file_name <-Sys.glob(input_path, dirmark = FALSE)

batch_summary <- read.table(file_name, header=TRUE, sep=",")


mean_tot_volume <- mean(batch_summary$total_volume)
mean_tot_elec_energy <- mean(batch_summary$total_elec_energy)
mean_tot_enthalpy <- mean(batch_summary$total_enthalpy)
mean_tot_energy_loss <- mean(batch_summary$energy_loss)
mean_t_out_mean <- mean(batch_summary$t_out_mean)
mean_t_in_mean <- mean(batch_summary$t_in_mean)
mean_t_amb_mean <- mean(batch_summary$t_amb_mean)
mean_total_events_count <- mean(batch_summary$total_events_count)
mean_upper_events_count <- mean(batch_summary$upper_events_count)
mean_lower_events_count <- mean(batch_summary$lower_events_count)
mean_num_samples <- mean(num_samples)
mean_packet_loss <- mean(batch_summary$packet_loss)

batch_mean <- data.frame(geyser_id,
                          mean_tot_volume,
                          mean_tot_elec_energy, mean_tot_enthalpy, mean_tot_energy_loss,
                          mean_t_out_mean, mean_t_in_mean, mean_t_amb_mean,
                          mean_total_events_count,
                          mean_upper_events_count, mean_lower_events_count,
                          mean_num_samples, mean_packet_loss)

output_path <- sprintf('~/Geyser/R/Batch/Output/BatchAnalysis_%d.csv', geyser_id)
write.table(batch_mean, file = output_path, append = FALSE, quote = TRUE, sep = ",",
            eol = "\n", na = "NA", dec = ".", row.names = FALSE,
            col.names = TRUE, qmethod = c("escape", "double"),
            fileEncoding = "")
