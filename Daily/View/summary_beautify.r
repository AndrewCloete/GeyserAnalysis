summary_beautify <- function(summary, drop, transpose){

    parms <- c("Date",
              "ID",
              "Total Volume (l)",
              "Electrical energy (kWh)","Effective energy (kWh)","Est cost (R)", "Energy loss (kWh)","Loss (%)",
              "Out Min (C)", "Out Mean (C)", "Out Max (C)",
              "In Min (C)", "In Mean (C)", "In Max (C)",
              "Amb Min (C)", "Amb Mean (C)", "Amb Max (C)",
              "Total #events", "Large #events","Small #events","Midpoint (l)",
              "#samples", "Packet loss (%)")


    colnames(summary) <- parms

    summary <- summary[,!(names(summary) %in% drop)]

    if(transpose){
      # first remember the names
      n <- summary$name

      # transpose all but the first column (name)
      summary <- as.data.frame(t(summary))
      colnames(summary) <- n
    }


    return(summary)
}
