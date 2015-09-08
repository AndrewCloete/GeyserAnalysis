# ---------------------------------------------------------------------------------------------------- #
#with(events, {
#  	s3d <- scatterplot3d(	start_time,   # x axis
#		         	duration,     # y axis
#		         	volume,    # z axis
#				pcol, 
#		         	main="3-D Scatterplot Example 1", 
#				scale.y=0.1, grid=TRUE, pch=19, type="h")
#	s3d.coords <- s3d$xyz.convert(start_time, duration, volume)
#	text(s3d.coords$x, s3d.coords$y,             # x and y coordinates
#		 labels=row.names(cold_events),               # text to plot
#		 cex=.5, pos=4)  
#})

# ---------------------------------------------------------------------------------------------------- #
#with(events, {
#  	s3d <- plot(		start_time,   # x axis
#		         	duration,     # y axis
#				col=pcol, 
#				pch=16,
#		         	main="Usage plot [volume inferred]")
#	text(start_time, duration, labels=sprintf("%5.1f",volume), cex= 0.7, , pos=3)
#	grid(nx = NULL, ny = NULL, col = "Black", lty = "dotted",
#     				lwd = 1, equilogs = TRUE)
#})
# ---------------------------------------------------------------------------------------------------- #

# ---------------------------------------------------------------------------------------------------- #
#with(events, {
#  	s3d <- plot(		start_time,   # x axis
#		         	volume,     # y axis
#				col=pcol, 
#				pch=16,
#		         	main="Usage plot [duration inferred]")
#	text(start_time, volume, labels=sprintf("%5.1f",duration), cex= 0.7, , pos=3)
#	grid(nx = NULL, ny = NULL, col = "Black", lty = "dotted",
#     				lwd = 1, equilogs = TRUE)
#})
# ---------------------------------------------------------------------------------------------------- #
#tryCatch({
#	with(events, {
#		
#		#--------- Balloon plot of volume
#		symbols(x=start_time, y=duration, circles=volume,
#			bg=events$pcol,  
#			inches=1/4,  
#			fg="black", xaxt="n", 
#			xlab="Start time [hour]", ylab="Duration [min]", 
#			main="Balloon events volume [l] (vs Duration)")
#		axis.POSIXct(1, 
#				at=seq(data_serverstamp[1], data_serverstamp[length(data_serverstamp)], by="hour"), 
#				labels=TRUE, format = "%H")
#		text(start_time, duration, 
#			labels=sprintf("%5.1f",volume), 
#			cex= 0.7, pos=3)
#		grid(nx = NULL, ny = NULL, col = "Black", lty = "dotted",
#			lwd = 1, equilogs = TRUE)
#
#		#---------- Balloon plot of flowrate on time
#		symbols(x=start_time, y=mean_flowrate, circles=volume,
#			bg=events$pcol,  
#			inches=1/4,  
#			fg="black", xaxt="n", 
#			xlab="Start time [hour]", ylab="Flowrate [l/min]", 
#			main="Balloon events volume [l] (vs Flowrate)")
#		axis.POSIXct(1, 
#				at=seq(data_serverstamp[1], data_serverstamp[length(data_serverstamp)], by="hour"), 
#				labels=TRUE, format = "%H")
#		text(start_time, mean_flowrate, 
#			labels=sprintf("%5.1f",volume), 
#			cex= 0.7, pos=3)
#		grid(nx = NULL, ny = NULL, col = "Black", lty = "dotted",
#			lwd = 1, equilogs = TRUE)
#
#
#		#---------- Balloon plot of duration
#		symbols(x=start_time, y=volume, circles=duration,
#			bg=events$pcol,  
#			inches=1/4,  
#			fg="black", xaxt="n", 
#			xlab="Start time [hour]", ylab="Volume [l]", 
#			main="Balloon events duration [min] (vs volume)")
#		axis.POSIXct(1, 
#				at=seq(data_serverstamp[1], data_serverstamp[length(data_serverstamp)], by="hour"), 
#				labels=TRUE, format = "%H")
#		text(start_time, volume, 
#			labels=sprintf("%5.1f",duration), 
#			cex= 0.7, pos=3)
#		grid(nx = NULL, ny = NULL, col = "Black", lty = "dotted",
#			lwd = 1, equilogs = TRUE)
#
#
#		#---------- Balloon plot of flowrate
#		symbols(x=duration, y=volume, circles=mean_flowrate, 
#			bg=events$pcol, 
#			inches=1/4,  
#			fg="black", 
#			xlab="Duration [min]", ylab="Volume [l]", 
#			main="Balloon event flowrate [l/min]")
#		text(duration, volume, 
#			labels=sprintf("%5.1f",mean_flowrate), 
#			cex= 0.7, pos=3)
#		grid(nx = NULL, ny = NULL, col = "Black", lty = "dotted",
#			lwd = 1, equilogs = TRUE)
#
#	})
#},warning = function(w) {
#    print("No water usage data detected. Try lowering threshold")
#})
# ---------------------------------------------------------------------------------------------------- #
