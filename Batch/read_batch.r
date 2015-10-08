
read_batch <- function(geyser_id){

  input_path <- sprintf('~/Geyser/R/Batch/Output/%d_*.csv', geyser_id)
  file_name <-Sys.glob(input_path, dirmark = FALSE)

  batch_summary <- read.table(file_name, header=TRUE, sep=",")

  return(batch_summary)

}
