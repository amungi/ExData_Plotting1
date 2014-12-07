## Coursera - Exploratory Data Analysis - Course: exdata-016
## Course Assignment 1
## Author: amungi

## plot4.R

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

# Output to file "plot4.png"

png(file = "plot4.png", width = 480, height = 480, units = "px", bg = "white")

# 4 plots required in a 2x2 layout

par(mfcol = c(2,2), # add plots by column
    mar = c(5,4,2,1) # margin
    )

# Add 1st plot (top left)
# Scatterplot with date-time on x-axis and Global Active Power on y-axis; plot only lines without points
with(epc2007_df, plot(DateTime, Global_active_power, type = "l", xlab = "", ylab = "Global Active Power"))

# Add 2nd plot (bottom left)
# Scatterplot with date-time on x-axis and Energy Sub_metering on y-axis; plot only lines without points
with(epc2007_df, {
    plot(DateTime, Sub_metering_1, type = "l", col = "black", xlab = "", ylab = "Energy sub metering")
    lines(DateTime, Sub_metering_2, type = "l", col = "red" )
    lines(DateTime, Sub_metering_3, type = "l", col = "blue" )
})

# Add legend in top right corner
legend("topright", "(x,y)", 
       legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), 
       col = c("black","red","blue"), 
       lty = 1, 
       lwd = 1
)

# Add 3rd plot (top right)
# Scatterplot with date-time on x-axis and Voltage on y-axis; plot only lines without points
with(epc2007_df, plot(DateTime, Voltage, type = "l", xlab = "datetime", ylab = "Voltage"))

# Add 4th plot (bottom right)
# Scatterplot with date-time on x-axis and Global Reactive Power on y-axis; plot only lines without points
with(epc2007_df, plot(DateTime, Global_reactive_power, type = "l", xlab = "datetime", ylab = "Global_reactive_power"))

dev.off()

# Script completed
