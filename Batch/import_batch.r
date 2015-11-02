source('~/Geyser/R/Daily/import_daily.r')
source('~/Geyser/R/Daily/events_daily.r')
source('~/Geyser/R/Daily/analyse_daily.r')


geyser_id = 107
start_date = '2015-10-26'
end_date = '2015-11-01'
skip = as.Date(c('2015-09-25', '2015-09-26', '2015-11-01'))

dates = seq(as.Date(start_date), as.Date(end_date), "days")
dates <- dates[is.na(match(dates,skip))]
print(dates)

batch_summary <- data.frame()

for(i in 1:length(dates)){

    print(sprintf("Import geyser_%g for %s...", geyser_id, dates[i]))
    data <- import_daily(dates[i], geyser_id)
    print("Calc events...")
    events <- events_daily(data)
    print("Analyse")
    daily_summary <- analyse_daily(data, events)


    batch_summary <- rbind(batch_summary, daily_summary)


}

print(batch_summary)


output_path <- sprintf('~/Geyser/R/Batch/Output/%d_%s_%s.csv', geyser_id, start_date, end_date)
write.table(batch_summary, file = output_path, append = FALSE, quote = TRUE, sep = ",",
            eol = "\n", na = "NA", dec = ".", row.names = FALSE,
            col.names = TRUE, qmethod = c("escape", "double"),
            fileEncoding = "")
