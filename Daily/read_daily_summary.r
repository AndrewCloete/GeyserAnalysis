read_daily_summary <- function(date, geyser_id){

  input_path <- sprintf('~/Geyser/R/Daily/Output/%d/%s_%d.csv', geyser_id, date, geyser_id)

  summary <- read.table(input_path, header=TRUE, sep=",")

  return(summary)
}
