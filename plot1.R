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

# Create Plot 1 and save as a .png file

png("plot1.png", bg = "transparent", width = 480, height = 480)

hist(power$Global_active_power, col = "red", main = "Global Active Power",
     xlab = "Global Active Power (kilowatts)", ylab = "Frequency")

dev.off()
