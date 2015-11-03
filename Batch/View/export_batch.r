source('~/Geyser/R/Batch/import_batch.r')
source('~/Geyser/R/Batch/View/plot_batch.r')


geyser_id = 109
start_date = '2015-10-26'
end_date = '2015-11-01'
skip = as.Date(c('2015-09-25', '2015-09-26', '2015-11-01'))

batch_summary <- import_batch(geyser_id, start_date, end_date, skip)

s <- render_batch_energy(batch_summary)

tofile_batch_summary(batch_summary, geyser_id, start_date, end_date)

print(s)
