


bds_beautify <- function(bds_summary){

    parms <- c("Date",
              "ID",
              "Total Volume (l)",
              "Electrical energy (kWh)","Effective energy (kWh)","Est cost (R)", "Energy loss (kWh)","Loss (%)",
              "Out Min (C)", "Out Mean (C)", "Out Max (C)",
              "In Min (C)", "In Mean (C)", "In Max (C)",
              "Amb Min (C)", "Amb Mean (C)", "Amb Max (C)",
              "Total #events", "Large #events","Small #events","Midpoint (l)",
              "#samples", "Packet loss (%)")


    colnames(bds_summary) <- parms

    print(bds_summary)

    return(bds_summary)
}
