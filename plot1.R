## This work is licensed under a Creative Commons Attribution-NonCommercial 
## 4.0 International License: http://creativecommons.org/licenses/by-nc/4.0/
## (c) 2015 Istvan Szente - szente.istvan@gmail.com

## Description: The goal here is simply to create plots in order to examine 
##              how household energy usage varies over a 2-day period in 
##              February, 2007 using data from the UC Irvine Machine Learning
##              Repository, a popular repository for machine learning datasets.
##              In particular, we will be using the “Individual household 
##              electric power consumption Data Set”: measurements of electric
##              power consumption in one household with a one-minute sampling
##              rate over a period of almost 4 years.

###############################################################################
## Loading and tidying source data.
###############################################################################

## checking if source file exist
if (!file.exists("household_power_consumption.txt")) {
  stop("household_power_consumption.txt is missing!")
}

## sqldf package is required for reading only subset of data from the source file
require("sqldf")

## reading only data from the dates 2007-02-01 and 2007-02-02
data <- read.csv.sql("household_power_consumption.txt", 
                     sql="select * from file where Date in ('1/2/2007', '2/2/2007')",
                     header=TRUE, sep=';')

## converting date and time columns from character to date and datetime
data$Time <- strptime(paste(data$Date, data$Time), "%d/%m/%Y %H:%M:%S")
data$Date <- as.Date(data$Date, "%d/%m/%Y")

###############################################################################
## Plot 1
###############################################################################

## opening a .png graphics device
png("plot1.png", bg = "transparent")

## plotting
hist(data$Global_active_power, col="red", main="Global Active Power", 
     xlab="Global Active Power (kilowatts)")

## closing graphics device
dev.off()

## removing data frame from memory
rm(data)