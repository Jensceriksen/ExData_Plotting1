### This script requires the "sqldf" package to be able to load the data.
### Please make sure that you have installed this package prior to running
### the script.

### This plot3.R script generates a single plot, containing line plots of 
### Sub_metering_1, Sub_metering_2, and Sub_metering 3, from Thursday midnight
### to Saturday midnight, from the datafile 'household_power_consumption.txt'.
### Furthermore, please ensure that the data file is in your working directory,
### otherwise the script won't work.

## Loads the sqldf package. Makes sure this package is installed.
## Also sets the locale to english.
invisible(Sys.setlocale(category = "LC_ALL", locale = "C"))
require("sqldf")

## Load data from the specified dates
mySql <- "SELECT * from file WHERE Date = '1/2/2007' OR Date = '2/2/2007'"
myData <- read.csv.sql("household_power_consumption.txt", sql=mySql, sep=";")

## Merge dates and times, and convert to Date/Time Class (not really required for this plot)
myData$datetime <- strptime(do.call(paste, c(myData[c("Date", "Time")], sep =", ")), format = "%d/%m/%Y, %H:%M:%S")

## Create line plot of Sub_metering_1, Sub_metering_2,
## and Sub_metering_3, over the course of the dates.
png("plot3.png")

plot(myData$datetime, myData$Sub_metering_1, type = "l", xlab ="", ylab = "Energy sub metering")
points(myData$datetime, myData$Sub_metering_2, type = "l", col ="red")
points(myData$datetime, myData$Sub_metering_3, type = "l", col ="blue")
legend("topright", c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), lty = c(1,1,1), col=c("black","red","blue"))

invisible(dev.off())

paste("Plot is saved as 'plot3.png' in your working directory")