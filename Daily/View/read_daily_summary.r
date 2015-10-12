read_daily_summary <- function(date, geyser_id){

  input_path <- sprintf('~/Geyser/R/Daily/Output/summary/%d/summary_%s_%d.csv', geyser_id, date, geyser_id)

  summary <- read.table(input_path, header=TRUE, sep=",")

  return(summary)
}


read_daily_summaries <- function(date, geyser_ids){

  summaries <- data.frame()

  for(i in 1:length(geyser_ids)){

    summary <- read_daily_summary(date, geyser_ids[i])

    summaries <- rbind(summaries, summary)
  }

  return(summaries)
}
