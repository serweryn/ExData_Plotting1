# reading only relevant data by skipping non relevant lines

# line numbers from input file
firstLineWith20070201 <- 66638
firstLineWith20070203 <- 69518

linesToSkip <- firstLineWith20070201 - 2
linesToRead <- firstLineWith20070203 - firstLineWith20070201

data <- read.csv("../household_power_consumption.txt",
                 sep = ";", na.strings = "?",
                 col.names = c("Date","Time","Global_active_power","Global_reactive_power","Voltage",
                               "Global_intensity","Sub_metering_1","Sub_metering_2","Sub_metering_3"),
                 nrows = linesToRead, skip = linesToSkip)

# date/time transformations
transform(data, Date = as.Date(Date, "%d/%m/%Y"))
transform(data, Time = strptime(Time, "%H:%M:%S"))

DateTime = strptime(paste(data$Date, data$Time, sep=" "), "%d/%m/%Y %H:%M:%S")

# generating plot
png(file = "plot4.png", width = 480, height = 480)

par(mfcol = c(2,2))

with(data, {
    plot(DateTime, Global_active_power, type = "l", xlab="", ylab = "Global Active Power")

    plot(DateTime, Sub_metering_1, type = "l", xlab="", ylab = "Energy sub metering")
    lines(DateTime, Sub_metering_2, col = "red")
    lines(DateTime, Sub_metering_3, col = "blue")
    legend("topright", lty = 1, bty="n", col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

    plot(DateTime, Voltage, type="l", xlab="datetime")

    plot(DateTime, Global_reactive_power, type="l", xlab="datetime")
})

dev.off()
