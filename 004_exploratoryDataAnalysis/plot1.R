### Library
library(lubridate)

options(stringsAsFactors = FALSE)
### Data for 2007-02-01 and 2007-02-02
hpc2d <- read.csv("004-projdata/HPC2d.csv", sep = ";",
                  header = TRUE)

###### Plot 1
png("graphs/004-projgraphs/plot1.png",
    width = 480, height = 480, type = "Xlib")
hist(hpc2d$Global_active_power, col = "red",
     xlab = "Global Active Power (kilowatts)",
     main = "Global Active Power")
dev.off()
