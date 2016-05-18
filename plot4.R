



## Part 1: Reading the Data

fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

zipFileName <- "exdata%2Fdata%2Fhousehold_power_consumption.zip"

fileName <- "household_power_consumption.txt"

if (!file.exists(fileName))
{ if (!file.exists(zipFileName))
{ download.file(fileURL, zipFileName)
}
    unzip(zipFileName)
    
}

dfNames <- read.table(fileName, header = TRUE, sep = ";", nrows = 1)

df <- read.table(fileName, header = TRUE, sep = ";", skip = 66637, nrows = 2880)

names(df) <- names(dfNames)
df.Date <- as.Date(df$Date, format = "%d/%m/%Y")
df.Time <- strptime(df$Time, format = "%H:%M:%S")

closeAllConnections()



## Part 2: Making the Plot

png("plot4.png")

par(mfrow = c(2,2))

plot(df$Time, df$Global_active_power, type = "s", xaxt = "n", 
     ylab = "Global Active Power (kilowatts)", xlim = c(1, 1440))
axis(1, at = c(1, 720, 1440), labels = c("Thu", "Fri", "Sat"))

plot(df$Time, df$Voltage, type = "s", xaxt = "n", 
     ylab = "Voltage", xlim = c(1, 1440))
axis(1, at = c(1, 720, 1440), labels = c("Thu", "Fri", "Sat"))

plot(df$Time, df$Sub_metering_1, type = "n", xaxt = "n", 
     ylab = "Energy sub metering", xlim = c(1, 1440))
lines(df$Time, df$Sub_metering_1, type = "s", xlim = c(1, 1440))
lines(df$Time, df$Sub_metering_2, type = "s", xlim = c(1, 1440), col = "red")
lines(df$Time, df$Sub_metering_3, type = "s", xlim = c(1, 1440), col = "blue")
axis(1, at = c(1, 720, 1440), labels = c("Thu", "Fri", "Sat"))
legend("topright", col = c("black", "red", "blue"), lty = c(1,1,1),
       legend  = c("Sub_metering_1", "Sub_metering_2", 
                   "Sub_metering_3"))

plot(df$Time, df$Global_reactive_power, type = "s", xaxt = "n", 
     ylab = "Global_reactive_power", xlim = c(1, 1440))
axis(1, at = c(1, 720, 1440), labels = c("Thu", "Fri", "Sat"))

dev.off()