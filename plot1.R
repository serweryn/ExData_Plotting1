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
transform(data, Date = as.Date(Date, "%d/%m/%y"))
transform(data, Time = strptime(Time, "%H:%M:%S"))

# generating plot
png(file = "plot1.png", width = 480, height = 480)

hist(data$Global_active_power, col = "red",
     main = "Global Active Power", xlab = "Global Active Power (kilowatts)")

dev.off()
