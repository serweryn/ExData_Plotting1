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
png(file = "plot3.png", width = 480, height = 480)

plot(DateTime, data$Sub_metering_1, type = "l", xlab="", ylab = "Energy sub metering")
lines(DateTime, data$Sub_metering_2, col = "red")
lines(DateTime, data$Sub_metering_3, col = "blue")
legend("topright", lty = 1, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

dev.off()
