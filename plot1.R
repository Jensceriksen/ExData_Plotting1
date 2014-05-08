### This script requires the "sqldf" package to be able to load the data.
### Please make sure that you have installed this package prior to running
### the script. Furthermore, please ensure that the data file is in your
### working directory, otherwise the script won't work.

### This plot1.R script generates a histogram plot of Global Active Power,
### from the datafile 'household_power_consumption.txt'.

## Loads the sqldf package. Makes sure this package is installed
require("sqldf")

## Load data from the specified dates
mySql <- "SELECT * from file WHERE Date = '1/2/2007' OR Date = '2/2/2007'"
myData <- read.csv.sql("household_power_consumption.txt", sql=mySql, sep=";")

## Merge dates and times, and convert to Date/Time Class (not really required for this plot)
myData$datetime <- strptime(do.call(paste, c(myData[c("Date", "Time")], sep =", ")), format = "%d/%m/%Y, %H:%M:%S")

## Create histogram of Global_active_power column data, and save it in a .png file
png("plot1.png")
hist(myData$Global_active_power, col = "red", main = paste("Global Active Power"), xlab = paste("Global Active Power (kilowatts)"))
invisible(dev.off())
paste("Plot is saved as 'plot1.png' in your working directory")