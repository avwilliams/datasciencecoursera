### Library
library(lubridate)

options(stringsAsFactors = FALSE)
### Data for 2007-02-01 and 2007-02-02
hpc2d <- read.csv("004-projdata/HPC2d.csv", sep = ";",
                  header = TRUE)

###### Plot 4
png("graphs/004-projgraphs/plot4.png",
    width = 480, height = 480, type = "Xlib")
par(mfrow = c(2, 2), mar = c(4, 4, 2, 1), oma = c(0, 0, 2, 0))
with(hpc2d, {
  plot(hpc2d$Date, hpc2d$Global_active_power,
       type = "l", xlab = "", ylab = "Global Active Power (kilowatts)")

  plot(hpc2d$Date, hpc2d$Voltage,
       type = "l", xlab = "datetime", ylab = "Voltage")

  plot(hpc2d$Date, hpc2d$Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering")
  lines(hpc2d$Date, hpc2d$Sub_metering_2, type = "l", col = "red")
  lines(hpc2d$Date,hpc2d$Sub_metering_3, type = "l", col = "blue")
  legend("topright", pch = 20, lty = c(1, 1, 1), col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

  plot(hpc2d$Date, hpc2d$Global_reactive_power,
       type = "l", xlab = "datetime", ylab = "Global_reactive_power")

})
dev.off()
