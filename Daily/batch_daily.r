source('~/Geyser/R/Daily/import_daily.r')
source('~/Geyser/R/Daily/events_daily.r')
source('~/Geyser/R/Daily/analyse_daily.r')

# This is a BATCH script that generates files based on geyser data analysis.
# It must be run BEFORE the Rwn is knitted. It must not be called within the Rwn
# script since knitr SUCKS at debugging!

date <- '2015-10-28'
geysers <- c(104, 106, 107, 108, 109, 112)

for(i in 1:length(geysers)){
  print(sprintf("Import geyser %g", geysers[i]))
  data <- import_daily(date, geysers[i])
  print(sprintf("Calc events %g", geysers[i]))
  events <- events_daily(data)
  print("Analyse")
  daily_summary <- analyse_daily(data, events)


  events_output_path <- sprintf('~/Geyser/R/Daily/Output/events/%d/events_%s_%d.csv', geysers[i], date, geysers[i])
  summary_output_path <- sprintf('~/Geyser/R/Daily/Output/summary/%d/summary_%s_%d.csv', geysers[i], date, geysers[i])

  write.table(events, file = events_output_path, append = FALSE, quote = TRUE, sep = ",",
              eol = "\n", na = "NA", dec = ".", row.names = FALSE,
              col.names = TRUE, qmethod = c("escape", "double"),
              fileEncoding = "")

  write.table(daily_summary, file = summary_output_path, append = FALSE, quote = TRUE, sep = ",",
              eol = "\n", na = "NA", dec = ".", row.names = FALSE,
              col.names = TRUE, qmethod = c("escape", "double"),
              fileEncoding = "")

}


#Transpose the data.frame at http://stackoverflow.com/questions/6778908/r-transposing-a-data-frame
#batch_daily_summary <- as.data.frame(t(batch_daily_summary))
#colnames(batch_daily_summary) <- parms
