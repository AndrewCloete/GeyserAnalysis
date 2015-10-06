geyser_id = 109
start_date = '2015-09-01'
end_date = '2015-10-05'


dates = seq(as.Date(start_date), as.Date(end_date), "days")
print(dates)

batch_summary <- data.frame()

for(i in 1:length(dates)){

  date <- dates[i]
  source('~/Geyser/R/Daily/import_daily.r')
  source('~/Geyser/R/Daily/analyse_daily.r')

  batch_summary <- rbind(batch_summary, summary)

}

print(batch_summary)


output_path <- sprintf('~/Geyser/R/Batch/Output/%d_%s_%s.csv', geyser_id, start_date, end_date)
write.table(batch_summary, file = output_path, append = FALSE, quote = TRUE, sep = ",",
            eol = "\n", na = "NA", dec = ".", row.names = FALSE,
            col.names = TRUE, qmethod = c("escape", "double"),
            fileEncoding = "")
