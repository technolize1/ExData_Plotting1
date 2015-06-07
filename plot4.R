## Read the data
rawData <- read.table("household_power_consumption.txt", sep = ";", header = TRUE, na.strings = "?")

## Turn date column into R intepretable date
rawData$Date <- as.Date(rawData$Date, "%d/%m/%Y")

##Combine Time and Date
timeDate <- paste(rawData$Date, rawData$Time)
timeDate <- strptime(timeDate, "%Y-%m-%d %T")
processedData <- cbind(rawData, timeDate)

## Start and end date
initialDate <- as.Date("2007-02-01")
finalDate <- as.Date("2007-02-02")

## Find needed rows and pick those rows
rowNeeded <- c(which(processedData$Date == initialDate), which(processedData$Date == finalDate))
tidyData <- processedData[rowNeeded, ]
tidyData <- tidyData[complete.cases(tidyData), ]

## Conversion to numeric type
gapData <- as.numeric(as.character(tidyData$Global_active_power))

## Plot graph
par(mfcol = c(2, 2))

plot(tidyData$timeDate, gapData, type = "l", ylab = "Global Active Power (kilowatts)", xlab = "")

with(tidyData, plot(timeDate, Sub_metering_1, type = "l", ylab = "Energy sub metering", xlab = ""))
with(tidyData, points(timeDate, Sub_metering_2, type = "l", col = "red"))
with(tidyData, points(timeDate, Sub_metering_3, type = "l", col = "blue"))
legend("topright", lwd = 1, bty = "n", col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), cex = 0.8)

with(tidyData, plot(timeDate, Voltage, type = "l", xlab = "datetime"))

with(tidyData, plot(timeDate, Global_reactive_power, type = "l", xlab = "datetime"))

## Output to PNG
dev.copy(png, file = "plot4.png", width = 480, height = 480)
dev.off()