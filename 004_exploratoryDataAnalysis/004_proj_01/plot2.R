### Library
library(lubridate)

options(stringsAsFactors = FALSE)
### Data for 2007-02-01 and 2007-02-02
hpc2d <- read.csv("004-projdata/HPC2d.csv", sep = ";",
                  header = TRUE)

###### Plot 2
png("graphs/004-projgraphs/plot2.png",
    width = 480, height = 480, type = "Xlib")
plot(hpc2d$Date, hpc2d$Global_active_power,
     type = "l", xlab = "", ylab = "Global Active Power (kilowatts)" )
dev.off()
