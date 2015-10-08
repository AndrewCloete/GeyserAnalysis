source('~/Geyser/R/Daily/import_daily.r')
source('~/Geyser/R/Daily/events_daily.r')
source('~/Geyser/R/Daily/analyse_daily.r')



batch_daily_summary <- function(date, geysers){

    batch_daily_summary <- data.frame()

    for(i in 1:length(geysers)){
      print(sprintf("Import geyser_%g", geysers[i]))
      data <- import_daily(date, geysers[i])
      print(sprintf("Calc events %g", geysers[i]))
      events <- events_daily(data)
      print("Analyse")
      daily_summary <- analyse_daily(data, events)

      batch_daily_summary <- rbind(batch_daily_summary, daily_summary)
    }

    #Transpose the data.frame at http://stackoverflow.com/questions/6778908/r-transposing-a-data-frame
    #batch_daily_summary <- as.data.frame(t(batch_daily_summary))
    #colnames(batch_daily_summary) <- parms

    #output_path <- sprintf('~/Geyser/R/Daily/Output/bds_%s.csv', date)

    #write.table(batch_daily_summary, file = output_path, append = FALSE, quote = TRUE, sep = ",",
    #            eol = "\n", na = "NA", dec = ".", row.names = FALSE,
    #            col.names = TRUE, qmethod = c("escape", "double"),
    #            fileEncoding = "")

    return(batch_daily_summary)
}
