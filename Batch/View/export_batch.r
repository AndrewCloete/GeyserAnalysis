source('~/Geyser/R/Batch/import_batch.r')
source('~/Geyser/R/Batch/View/plot_batch.r')


geyser_id = 107
start_date = '2015-09-10'
end_date = '2015-11-07'
skip = as.Date(c('2015-10-01'))


batch_summary <- import_batch(geyser_id, start_date, end_date, skip)
tofile_batch_summary(batch_summary, geyser_id, start_date, end_date)
#all_data <- list()

#all_data[[1]] <- import_batch(104, start_date, end_date, skip)
#all_data[[2]] <- import_batch(106, start_date, end_date, skip)


s <- render_batch_volume(batch_summary)

#s <- render_batch_packet(batch_summary)
tofile_batch(s, "~/Geyser/Plots/ExportBatch", geyser_id, start_date, 'volume', "png")



print(s)
