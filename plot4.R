## plot4.R for Week 1 Exploratory Analysis

### This script reads data household_power_consumption.txt file and creates 4
### plots in one graphic for the time period from 2007-02-01 to 
### 2007-02-02

#############################################################

## Set working directory to the location which contains "household_power_consumption.txt"
# setwd("Type your working directory here")
list.files() #To view files in working directory

## Read the first 100 rows to get a preview of the data
samp.dat <- read.table(file  = "household_power_consumption.txt", header = TRUE, nrows = 100,
                       sep = ";")
head(samp.dat)

## Determine the first row which with date 1/2/2007 and last row with 2/2/2007
head(which(as.character(read.table(file  = "household_power_consumption.txt", header = TRUE,
                                   sep = ";")[, 1]) == "1/2/2007"))
tail(which(as.character(read.table(file  = "household_power_consumption.txt", header = TRUE,
                                   sep = ";")[, 1]) == "2/2/2007"))

## Read, store, and preview data from rows of interest. Also assigns names
hhpc <- read.table(file  = "household_power_consumption.txt", header = TRUE, 
                   skip = 66636, nrows = 2880, sep = ";")
names(hhpc) <- names(read.table(file  = "household_power_consumption.txt", 
                                header = TRUE, nrows = 10, sep = ";"))
head(hhpc)
tail(hhpc)
str(hhpc)

## Load handy packages
library(dplyr)
library(tidyr)
library(lubridate)

## Convert to table data frame format and merge date and time columns
hhpc <- tbl_df(hhpc)
hhpc <- unite(hhpc, col = "datetime", Date, Time, sep = " ", remove = FALSE)
hhpc$datetime <- dmy_hms(hhpc$datetime) # Convert to date time class

## Update par to allow multiple plots and adjust margins
par(mfrow = c(2, 2), mar = c(4, 4, 2, 1))

## Preview plot
# 1
plot(hhpc$datetime, hhpc$Global_active_power, type = "l", 
     ylab = "Global Active Power (kilowatts)", xlab = "Time")
# 2
plot(hhpc$datetime, hhpc$Voltage, type = "l", 
     ylab = "Voltage", xlab = "datetime")
# 3
plot(hhpc$datetime, hhpc$Sub_metering_1, type = "l", 
     ylab = "Energy sub metering", xlab = "Time")
lines(hhpc$datetime, hhpc$Sub_metering_2, col = "red")
lines(hhpc$datetime, hhpc$Sub_metering_3, col = "blue")
legend("topright", lty = 1, col = c("black", "red", "blue"), bty = "n", 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
# 4
plot(hhpc$datetime, hhpc$Global_reactive_power, type = "l", 
     ylab = "Voltage", xlab = "datetime")

## Create png file of plot
png(filename = paste("plot4", ".png", sep = ""))
par(mfrow = c(2, 2), mar = c(4, 4, 2, 1))
# 1
plot(hhpc$datetime, hhpc$Global_active_power, type = "l", 
     ylab = "Global Active Power (kilowatts)", xlab = "Time")
# 2
plot(hhpc$datetime, hhpc$Voltage, type = "l", 
     ylab = "Voltage", xlab = "datetime")
# 3
plot(hhpc$datetime, hhpc$Sub_metering_1, type = "l", 
     ylab = "Energy sub metering", xlab = "Time")
lines(hhpc$datetime, hhpc$Sub_metering_2, col = "red")
lines(hhpc$datetime, hhpc$Sub_metering_3, col = "blue")
legend("topright", lty = 1, col = c("black", "red", "blue"), bty = "n", 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
# 4
plot(hhpc$datetime, hhpc$Global_reactive_power, type = "l", 
     ylab = "Voltage", xlab = "datetime")
dev.off()

