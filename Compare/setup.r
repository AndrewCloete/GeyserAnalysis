start_time <- "15-09-09 02:00:00"
end_time <- "15-09-10 02:00:00"
period <- 24*60*60 + 60 # in seconds
duration <- 24*60*60 + 60




start_time <- as.POSIXct(strptime(start_time, "%Y-%m-%d %H:%M:%S"))
end_time <- as.POSIXct(strptime(end_time, "%Y-%m-%d %H:%M:%S"))
start_dates <- seq(start_time, end_time, duration)


start_dates <- as.POSIXct(strptime(start_dates, "%Y-%m-%d %H:%M:%S"))
end_dates <- start_dates + duration
date_count <- length(start_dates)

print("------- START dates --------")
print(start_dates)
print("--------- END dates --------")
print(end_dates)

subsets <- list()




# ---------------- Other time subsets -------------------------
## on or before the 2nd at 01:30
#df1 <- subset(df, tm <= as.POSIXct('2011-08-02 1:30'))

## everying on the 3rd
#df2 <- subset(df, format(tm,'%d')=='03')

## everything in hours  11am through 1pm inclusive
#df3 <- subset(df, format(tm,'%H') %in% c('11','12','13'))




