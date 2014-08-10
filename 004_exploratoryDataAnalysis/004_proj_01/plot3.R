### Library
library(lubridate)

options(stringsAsFactors = FALSE)
### Data for 2007-02-01 and 2007-02-02
hpc2d <- read.csv("004-projdata/HPC2d.csv", sep = ";",
                  header = TRUE)

###### Plot 3
png("graphs/004-projgraphs/plot3.png",
    width = 480, height = 480, type = "Xlib")
with(hpc2d, plot(hpc2d$Date, hpc2d$Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering"))
with(hpc2d, lines(hpc2d$Date, hpc2d$Sub_metering_2, type = "l", col = "red"))
with(hpc2d, lines(hpc2d$Date,hpc2d$Sub_metering_3, type = "l", col = "blue"))
legend("topright", lty = c(1, 1, 1), col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.off()
