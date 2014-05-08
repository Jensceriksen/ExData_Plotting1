### This script requires the "sqldf" package to be able to load the data.
### Please make sure that you have installed this package prior to running
### the script. Furthermore, please ensure that the data file is in your
### working directory, otherwise the script won't work.

### This plot2.R script generates a line plot of Global Active Power from
### Thursday midnight to Saturday midnight, from the datafile 
### 'household_power_consumption.txt'.

## Loads the sqldf package. Makes sure this package is installed.
## Also sets the locale to english.
invisible(Sys.setlocale(category = "LC_ALL", locale = "C"))
require("sqldf")

## Load data from the specified dates
mySql <- "SELECT * from file WHERE Date = '1/2/2007' OR Date = '2/2/2007'"
myData <- read.csv.sql("household_power_consumption.txt", sql=mySql, sep=";")

## Merge dates and times, and convert to Date/Time Class (not really required for this plot)
myData$datetime <- strptime(do.call(paste, c(myData[c("Date", "Time")], sep =", ")), format = "%d/%m/%Y, %H:%M:%S")

## Create line plot of Global_active_power over the course of the dates
png("plot2.png")
plot(myData$datetime,myData$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)")
invisible(dev.off())
paste("Plot is saved as 'plot2.png' in your working directory")