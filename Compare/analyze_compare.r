
start_threshold <- 0.5
stop_threshold <- 0.5

print(ln)
print(sprintf("Start detection threshold: %0.1f litres", start_threshold))
print(sprintf("Stop detection threshold: %0.1f litres", stop_threshold))
print(ln)

# ------------------------------- Detect and combine events ----------------------------------------- #
events <- list()
for(i in 1:date_count){


	e <- extract_events(subsets[[i]])	

	print("------------------------ List of events ------------------------")
	events[[i]] <- e
# ----------------------------------------------------------------------------------------------------- #

}
