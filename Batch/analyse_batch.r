geyser_id = 107


input_path <- sprintf('~/Geyser/R/Batch/Output/%d_*.csv', geyser_id)
file_name <-Sys.glob(input_path, dirmark = FALSE)



batch_test <- read.table(file_name, header=TRUE, sep=",")




print(colMeans(batch_test))
