## Coursera - Exploratory Data Analysis - Course: exdata-016
## Course Assignment 1
## Author: amungi

## plot2.R

# (1) Assumed that the data file "Electric power consumption":
# https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip 
# is already downloaded and unzipped on your local machine.
# (2) Assumed that the data file "household_power_consumption.txt" is already in the R working directory

## [A] Read the entire dataset: 2075259 observations of 9 variables

# Missing / NA values are "?"

# Columns : Column classes
# Date : "character" (should be converted to date when required)
# Time : "character" (should be converted to time when required)
# Global_active_power : "numeric" (household global minute-averaged active power (in kilowatt))
# Global_reactive_power : "numeric" (household global minute-averaged reactive power (in kilowatt))
# Voltage : "numeric" (minute-averaged voltage (in volt))
# Global_intensity : "numeric" (household global minute-averaged current intensity (in ampere))
# Sub_metering_1 : "numeric" (energy sub-metering No. 1 (in watt-hour of active energy) ; Kitchen)
# Sub_metering_2 : "numeric" (energy sub-metering No. 2 (in watt-hour of active energy) ; Laundry room)
# Sub_metering_3 : "numeric" (energy sub-metering No. 3 (in watt-hour of active energy) ; 
#                               Electric water-heater and air-conditioner)

epc_df <- read.csv("./household_power_consumption.txt", header = TRUE, sep = ";", na.strings = "?",
                   colClasses = c("character","character","numeric","numeric","numeric","numeric","numeric","numeric","numeric")
)

# [B] Subset the rows for dates = 1/2/2007 and 2/2/2007
# 2880 observations of 9 variables

epc2007_df <- subset(epc_df, Date == "1/2/2007" | Date == "2/2/2007")

# Combine date and time columns into a date-time value
epc2007_df$DateTime <- as.POSIXct(strptime(paste(epc2007_df$Date, epc2007_df$Time), format="%d/%m/%Y %H:%M:%S"))

# [C] Plot to PNG device - 480x480 pixels

# Plot Date Time (X-axis) against "Global Active Power (kilowatts)" (Y-axis)

# Output to file "plot2.png"

png(file = "plot2.png", width = 480, height = 480, units = "px", bg = "white")

par(mfrow = c(1,1), mar = c(5,4,4,2))


# Scatterplot with date-time on x-axis and Global Active Power on y-axis; plot only lines without points
with(epc2007_df, plot(DateTime, Global_active_power, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)"))


dev.off()

# Script completed
