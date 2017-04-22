## plot2.R for Week 1 Exploratory Analysis

### This script reads data household_power_consumption.txt file and creates a
### plot of Global Active Power for the time period from 2007-02-01 to 
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

## Preview plot
# default width and height is 480
plot(hhpc$datetime, hhpc$Global_active_power, type = "l", 
     ylab = "Global Active Power (kilowatts)", xlab = "Time")

## Create png file of plot
png(filename = paste("plot2", ".png", sep = ""))
plot(hhpc$datetime, hhpc$Global_active_power, type = "l", 
     ylab = "Global Active Power (kilowatts)", xlab = "Time")
dev.off()