source('~/Geyser/R/Daily/import_daily.r')
source('~/Geyser/R/Daily/View/plot_daily.r')
source('~/Geyser/R/Daily/events_daily.r')
source('~/Geyser/R/Daily/analyse_daily.r')

# -------------------------------- SETUP ---------------------------------------
geyser_id = 112
start_date = '2015-09-04'
end_date = '2015-11-18'

skip_104 = c( '2015-10-13', '2015-10-14', '2015-11-02')

skip_106 = c( '2015-10-02', '2015-10-03', '2015-10-04', '2015-10-05', '2015-10-06',
              '2015-10-07', '2015-10-08', '2015-10-13', '2015-10-14', '2015-11-01')

skip_107 = c( '2015-09-07', '2015-09-10', '2015-09-11', '2015-09-13', '2015-09-20',
              '2015-10-05', '2015-10-06', '2015-10-07', '2015-10-13',
              '2015-09-25', '2015-10-04', '2015-10-14', '2015-11-01', '2015-11-02',
              '2015-11-09', '2015-11-18')

skip_108 = c( '2015-09-04', '2015-09-07', '2015-09-08', '2015-09-09', '2015-09-10',
              '2015-09-11', '2015-10-08', '2015-10-09', '2015-10-10', '2015-10-11',
              '2015-10-12', '2015-10-13',
              '2015-10-14', '2015-10-20', '2015-10-21', '2015-10-22', '2015-10-23',
              '2015-10-24', '2015-10-25', '2015-10-26', '2015-11-09')

skip_109 = c( '2015-09-13', '2015-09-21', '2015-09-22', '2015-09-26', '2015-09-27',
              '2015-09-28', '2015-10-02', '2015-10-03', '2015-10-04', '2015-10-05',
              '2015-10-06', '2015-10-07', '2015-10-13', '2015-10-14', '2015-10-24',
              '2015-10-31', '2015-11-01', '2015-11-01', '2015-11-02', '2015-11-15')

skip_110 = c( '2015-09-09', '2015-09-10', '2015-09-18', '2015-09-19', '2015-09-20',
              '2015-10-05', '2015-10-06', '2015-10-07', '2015-10-13', '2015-10-14',
              '2015-10-28', '2015-10-29', '2015-10-30', '2015-11-03')

skip_112 = c( '2015-09-08', '2015-09-10', '2015-09-24', '2015-09-25', '2015-09-26',
              '2015-09-27', '2015-09-28', '2015-10-04', '2015-10-04', '2015-10-05',
              '2015-10-06', '2015-10-07', '2015-10-13', '2015-10-14', '2015-10-27',
              '2015-11-01', '2015-11-02')

skip = as.Date(eval(parse(text=sprintf("skip_%d", geyser_id))))
# ------------------------------------------------------------------------------

dates = seq(as.Date(start_date), as.Date(end_date), "days")
dates <- dates[is.na(match(dates,skip))]
print(dates)

summary <- data.frame()

for(i in 1:length(dates)){
  print(sprintf("Import geyser %g", geyser_id))
  data <- import_daily(dates[i], geyser_id)
  print(sprintf("Calc events %g", geyser_id))
  events <- events_daily(data)
  #data <- add_daily_schedule_104(data)
  daily_summary <- analyse_daily(data, events)
  summary <- rbind(summary, daily_summary)

  #s <- render_daily_raw(data)
  #tofile_daily(s, "~/Geyser/Plots/RawDaily", geyser_id, dates[i], 'raw', "png")

  #s <- render_daily_raw_flow(data)
  #tofile_daily(s, "~/Geyser/Plots/RawDaily", geyser_id, dates[i], 'flow', "png")

  s <- render_daily_balloon(dates[i], events)
  #tofile_daily(s, "~/Geyser/Plots/RawDaily", geyser_id, dates[i], 'balloon', "png")



  print(s)


  if(length(data$server_stamp) < 1008){
    print(sprintf("Packet-loss on %s", dates[i]))
  }
}


tofile_batch_summary(summary, geyser_id, start_date, end_date)
