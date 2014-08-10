## 004 Exploratory Data Analysis
Projects and Assignments

### Project One
Description: Measurements of electric power consumption in one household

with a one-minute sampling rate over a period of almost 4 years.

Different electrical quantities and some sub-metering values are available.

#### Loading the data
We will only be using data from the dates 2007-02-01 and 2007-02-02.

Extraction specific data for the assignment using command line tools.
```
# range of data of interest
grep "^[1]/2/2007" HPC.txt | less
grep "^[2]/2/2007" HPC.txt | less

# Data file HPC2d: HPC for 2 days.
grep "^[12]/2/2007" HPC.txt >> HPC2d.txt
```

#### Making Plots
Examination of how household energy usage varies over a 2-day period in February, 2007.

Task: Reconstruct plots, all of which were constructed using the
base plotting system.

When finished should be four PNG files and four R code files.

## Plots
### Plot 1

![Plot 1](https://github.com/avwilliams/datasciencecoursera/blob/master/graphs/004-projgraphs/plot1.png)

#### Code: [plot1.R](https://github.com/avwilliams/datasciencecoursera/blob/master/004_exploratoryDataAnalysis/004_proj_01/plot1.R)
```
options(stringsAsFactors = FALSE)

# Data for 2007-02-01 and 2007-02-02
hpc2d <- read.csv("https://github.com/avwilliams/datasciencecoursers/data/004-projdata/HPC2d.csv",
                  sep = ";",
                  header = TRUE)

# Plot 1
png("https://github.com/avwilliams/datasciencecoursera/graphs/004-projgraphs/plot1.png",
    width = 480, height = 480, type = "Xlib")
hist(hpc2d$Global_active_power, col = "red",
     xlab = "Global Active Power (kilowatts)",
     main = "Global Active Power")
dev.off()
```

### Plot 2
![Plot 2](https://github.com/avwilliams/datasciencecoursera/blob/master/graphs/004-projgraphs/plot2.png)

#### Code: [plot2.R](https://github.com/avwilliams/datasciencecoursera/blob/master/004_exploratoryDataAnalysis/004_proj_01/plot2.R)
```
# Library
library(lubridate)

options(stringsAsFactors = FALSE)
# Data for 2007-02-01 and 2007-02-02
hpc2d <- read.csv("https://github.com/avwilliams/datasciencecoursers/data/004-projdata/HPC2d.csv",
                  sep = ";",
                  header = TRUE)

# Plot 2
png("https://github.com/avwilliams/datasciencecoursera/graphs/004-projgraphs/plot2.png",
    width = 480, height = 480, type = "Xlib")
plot(hpc2d$Date, hpc2d$Global_active_power,
     type = "l", xlab = "", ylab = "Global Active Power (kilowatts)" )
dev.off()
```

### Plot 3
![Plot 3](https://github.com/avwilliams/datasciencecoursera/blob/master/graphs/004-projgraphs/plot3.png)

#### Code: [plo3.R](https://github.com/avwilliams/datasciencecoursera/blob/master/004_exploratoryDataAnalysis/004_proj_01/plot3.R)
```
# Library
library(lubridate)

options(stringsAsFactors = FALSE)
# Data for 2007-02-01 and 2007-02-02
hpc2d <- read.csv("https://github.com/avwilliams/datasciencecoursers/data/004-projdata/HPC2d.csv",
                  sep = ";",
                  header = TRUE)

# Plot 3
png("https://github.com/avwilliams/datasciencecoursera/graphs/004-projgraphs/plot3.png",
    width = 480, height = 480, type = "Xlib")
with(hpc2d, plot(hpc2d$Date, hpc2d$Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering"))
with(hpc2d, lines(hpc2d$Date, hpc2d$Sub_metering_2, type = "l", col = "red"))
with(hpc2d, lines(hpc2d$Date,hpc2d$Sub_metering_3, type = "l", col = "blue"))
legend("topright", lty = c(1, 1, 1), col = c("black", "red", "blue"),
        legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.off()

```

### Plot 4
![Plot 4](https://github.com/avwilliams/datasciencecoursera/blob/master/graphs/004-projgraphs/plot4.png)

#### Code: [plot4.R](https://github.com/avwilliams/datasciencecoursera/blob/master/004_exploratoryDataAnalysis/004_proj_01/plot4.R)
```
### Library
library(lubridate)

options(stringsAsFactors = FALSE)
# Data for 2007-02-01 and 2007-02-02
hpc2d <- read.csv("https://github.com/avwilliams/datasciencecoursers/data/004-projdata/HPC2d.csv",
                  sep = ";",
                  header = TRUE)

# Plot 4
png("https://github.com/avwilliams/datasciencecoursera/graphs/004-projgraphs/plot1.png",
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
  legend("topright", pch = 20, lty = c(1, 1, 1), col = c("black", "red", "blue"),
        legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

  plot(hpc2d$Date, hpc2d$Global_reactive_power,
       type = "l", xlab = "datetime", ylab = "Global_reactive_power")

})
dev.off()
```
