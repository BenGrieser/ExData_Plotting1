



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

png("plot2.png")


plot(df$Time, df$Global_active_power, type = "s", xaxt = "n", 
     ylab = "Global Active Power (kilowatts)", xlim = c(1, 1440))
axis(1, at = c(1, 720, 1440), labels = c("Thu", "Fri", "Sat"))

dev.off()