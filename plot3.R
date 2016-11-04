## plot3.R
## written by Vincent O. Chan, 03 NOV 2016
## all rights reserved

## This script plots data from the household power consumption
## dataset from UCI's Machine Learning Repository. Data plotted is for dates
## 01 FEB 2007 thru 02 FEB 2007.

## The plot created compares submetered usage against time.

## download and read the text file with cols as characters
datazip <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",
              datazip)
pwrdata <- read.table(unz(datazip,"household_power_consumption.txt"), sep=";", head=TRUE,
                      colClasses="character")
unlink(datazip)

## DATA CLEANING

## remove data not from 2/1/2007 or 2/2/2007
pwrdata <- subset(pwrdata, pwrdata$Date=="2/2/2007"|pwrdata$Date=="1/2/2007")

## replace Date column with a POSIXct object
pwrdata$Date <- as.POSIXct(paste(pwrdata$Date,pwrdata$Time), format="%d/%m/%Y %H:%M:%S")

## drop the Time column
pwrdata <- pwrdata[,c(1,3:9)]

## convert numeric values to numeric datatype
pwrdata[,2:8] <- apply(pwrdata[,2:8],2,as.numeric)

## CREATE PLOT3

## open the PNG graphics device (desired .png size is the same as the default size)
png(filename="plot3.png")

## initialize a plot w/ labels as desired
plot(pwrdata$Date,pwrdata$Sub_metering_1,pch=NA,
     xlab=NA,ylab="Energy sub metering")
## plot each submetering line in a different color
lines(pwrdata$Date,pwrdata$Sub_metering_1)
lines(pwrdata$Date,pwrdata$Sub_metering_2,col="red")
lines(pwrdata$Date,pwrdata$Sub_metering_3,col="blue")
## create a legend in the top right corner
## legend should indicate linetypes for each subset of data
legend("topright",c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       col=c("black","red","blue"),lwd=1)

## close the graphics device
dev.off()