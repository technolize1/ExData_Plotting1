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
hist(gapData, xlab = "Global Active Power (kilowatts)", col = "red", main = "Global Active Power", breaks = 12)

## Output to PNG
dev.copy(png, file = "plot1.png", width = 480, height = 480)
dev.off()