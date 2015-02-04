# Read Dataset: Electric power consumption [20Mb]

if (file.exists("household_power_consumption.txt")) {
    power <- read.table("household_power_consumption.txt", header = TRUE, 
                        sep = ";",na.strings = "?", skip = 66636, nrow = 2880,
                        col.names = colnames(read.table("household_power_consumption.txt",
                                                        sep = ";", nrow = 1, header = TRUE)))
    
} else{
    url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
    zipfile <- "household_power_consumption.zip"
    download.file(url, zipfile)
    unzip(zipfile)
    power <- read.table("household_power_consumption.txt", header = TRUE, 
                        sep = ";",na.strings = "?", skip = 66636, nrow = 2880,
                        col.names = colnames(read.table("household_power_consumption.txt",
                                                        sep = ";", nrow = 1, header = TRUE)))
    unlink(zipfile)
}

# Create new POSIXlt Date_time variable

power$Date_time <- strptime(paste(power$Date, power$Time),  format = "%d/%m/%Y %H:%M:%S")

# Create Plot 3 and save as a .png file

png("plot3.png", bg = "transparent", width = 480, height = 480)

plot(range(power$Date_time, na.rm = TRUE),
     range(c(power$Sub_metering_1, power$Sub_metering_2,
             power$Sub_metering_3), na.rm = TRUE),
     type = "n", xlab = "", ylab = "Energy sub metering")
lines(power$Date_time, power$Sub_metering_1)
lines(power$Date_time, power$Sub_metering_2, col = "red")
lines(power$Date_time, power$Sub_metering_3, col = "blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=c(1, 1, 1), 
       lwd=c(1, 1, 1), col=c("black", "red", "blue"))

dev.off()
