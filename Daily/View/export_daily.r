source('~/Geyser/R/Daily/import_daily.r')
source('~/Geyser/R/Daily/View/plot_daily.r')
source('~/Geyser/R/Daily/events_daily.r')


geyser_id = 107
start_date = '2015-10-28'
end_date = '2015-10-28'
skip = as.Date(c('2200-09-25', '2015-09-10')) #'2015-09-25', '2015-09-26', '2015-11-01' # '2015-10-09', '2015-10-10', '2015-10-11', '2015-10-21', '2015-10-22', '2015-10-23', '2015-10-24', '2015-10-25'

dates = seq(as.Date(start_date), as.Date(end_date), "days")
dates <- dates[is.na(match(dates,skip))]
print(dates)

for(i in 1:length(dates)){
  print(sprintf("Import geyser %g", geyser_id))
  data <- import_daily(dates[i], geyser_id)
  print(sprintf("Calc events %g", geyser_id))
  events <- events_daily(data)

  s <- render_daily_raw(data)
  tofile_daily(s, "~/Geyser/Plots/RawDaily", geyser_id, dates[i], 'raw', "pdf")

  s <- render_daily_raw_flow(data)
  tofile_daily(s, "~/Geyser/Plots/RawDaily", geyser_id, dates[i], 'flow', "pdf")

  s <- render_daily_balloon(dates[i], events)
  tofile_daily(s, "~/Geyser/Plots/RawDaily", geyser_id, dates[i], 'balloon', "pdf")
}
