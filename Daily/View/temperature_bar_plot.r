library(ggplot2)

#svg(file="~/test.svg", width=5)



data <- structure(list(Outlet = c(t_out_min, t_out_mean, t_out_max),
                        Inlet = c(t_in_min, t_in_mean, t_in_max),
                        Ambient = c(t_amb_min, t_amb_mean, t_amb_max)),
                        .Names = c("Outlet", "Inlet", "Ambient"), class = "data.frame",
                        row.names = c("Min", "Mean", "Max"))
#print(data)

colours <- c("cyan2", "gold", "coral1")
barplot(as.matrix(data), main="Temperature summary", ylab = "C", cex.lab = 1.5, cex.main = 1.4, beside=TRUE, col=colours, ylim=c(0,80))
legend("topright", c("Min","Mean","Max"), cex=1.3, bty="n", fill=colours)

#s <- ggplot(data, stat="identity", aes(x = factor(Outlet)))
#s <- s + geom_bar()
#print(s)

#dev.off()



#data <- structure(list(Min = c(t_out_min, t_in_min, t_amb_min),
#                        Mean = c(t_out_mean, t_in_mean, t_amb_mean),
#                        Max = c(t_out_max, t_in_max, t_amb_max)),
#                        .Names = c("Min", "Mean", "Max"), class = "data.frame",
#                        row.names = c("Oulet", "Inlet", "Ambient"))
