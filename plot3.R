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

## Initiate PNG
png("./plot3.png", width = 480, height = 480)

## Plot graph
with(tidyData, plot(timeDate, Sub_metering_1, type = "l", ylab = "Energy sub metering", xlab = ""))
with(tidyData, points(timeDate, Sub_metering_2, type = "l", col = "red"))
with(tidyData, points(timeDate, Sub_metering_3, type = "l", col = "blue"))
legend("topright", lwd = 1, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), cex = 0.8)


## Output to PNG
dev.off()