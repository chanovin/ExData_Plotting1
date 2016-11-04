## plot4.R
## written by Vincent O. Chan, 03 NOV 2016
## all rights reserved

## This script plots four line graphs from the household power consumption
## dataset from UCI's Machine Learning Repository. Data plotted is for dates
## 01 FEB 2007 thru 02 FEB 2007.

## Plot 1: Global active power by time
## Plot 2: Submetering by time for each of 3 submeters
## Plot 3: Voltage by time
## Plot 4: Global reactive power by time

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

## convert remaining values to numeric datatype
pwrdata[,2:8] <- apply(pwrdata[,2:8],2,as.numeric)

## CREATE PLOT4

## open the PNG graphics device (desired .png size is the same as the default size)
png(filename="plot4.png")

## set the plot to a 2x2 matrix of 4 subplots
## plots will populate column-wise
par(mfcol=c(2,2),mar=c(4,4,4,2))

## initialize top left (first) plot w/ labels as desired
plot(pwrdata$Date,pwrdata$Global_active_power,pch=NA,
     xlab=NA,ylab="Global Active Power")
## now plot the line global active power vs time
lines(pwrdata$Date,pwrdata$Global_active_power)

## initialize bottom left (second) plot w/ labels as desired
plot(pwrdata$Date,pwrdata$Sub_metering_1,pch=NA,
     xlab=NA,ylab="Energy sub metering")
## plot each of the submetering lines vs time in different colors
lines(pwrdata$Date,pwrdata$Sub_metering_1)
lines(pwrdata$Date,pwrdata$Sub_metering_2,col="red")
lines(pwrdata$Date,pwrdata$Sub_metering_3,col="blue")
## add a legend for the lines
## do not place an outline/border on the legend
legend("topright",c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       col=c("black","red","blue"),lwd=1,box.lwd=NA)

## initialize top right (third) plot w/ labels as desired
plot(pwrdata$Date,pwrdata$Voltage,xlab="datetime",ylab="Voltage",pch=NA)
## plot the line voltage vs time
lines(pwrdata$Date,pwrdata$Voltage)

## intialize bottom right (fourth) plot w/ labels as desired
plot(pwrdata$Date,pwrdata$Global_reactive_power,xlab="datetime",
     ylab="Global_reactive_power",pch=NA)
## plot the global reactive power vs time
lines(pwrdata$Date,pwrdata$Global_reactive_power)

## close the graphics device
dev.off()