library(RMySQL)
source('~/Geyser/R/event_detector.r')

import_daily <- function(date, geyser_id){

    start_time = as.POSIXct(strptime(sprintf("%s 02:00:00", date), "%Y-%m-%d %H:%M:%S"))
    end_time = start_time + 24*60*60

    query = sprintf("select * from timestamps where geyser_id=%d and server_stamp>='%s' and server_stamp<='%s';", geyser_id, start_time, end_time)
    #print(query)


      con <- dbConnect(MySQL(), user="intelligeyser", password="ewhM2Mnscl", dbname="GeyserM2M", host="146.232.128.163")
      rs <- dbSendQuery(con, query)
      data <- fetch(rs, n=1440)
      huh <- dbHasCompleted(rs)
      dbClearResult(rs)
      dbDisconnect(con)

      # ------------------------ Prepare the data ------------------------------

      # Native DATE representation
      data$server_stamp <- as.POSIXct(strptime(data$server_stamp, "%Y-%m-%d %H:%M:%S"))

      # Differentiate acc volume to get flow
      data$hot_flow_dif <- dif(data$hot_litres_tot)
      data$kwatt_dif <- dif(data$kwatt_tot)


    return(data)
}
