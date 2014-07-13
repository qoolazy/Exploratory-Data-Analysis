# Change working directory
setwd("~/Desktop/R study/exploratory_data_analysis/project1")

# Download, unzip and read the data
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl, destfile="household_power_consumption.zip", method="curl")
dateDownloaded <- date()
dateDownloaded
hpc <- read.table(unz("household_power_consumption.zip", "household_power_consumption.txt"), 
                  header=T, sep=";", na.strings="?")
head(hpc)

# Subset household power consumption for Feb. 1 and 2, 2007 only
hpc2 <- hpc[as.character(hpc$Date) %in% c("1/2/2007", "2/2/2007"),]
head(hpc2)

# Convert the Date and Time variables to Date/Time classes
hpc2$DateTime <- paste(hpc2$Date, hpc2$Time)
hpc2$DateTime <- strptime(hpc2$DateTime, format = "%d/%m/%Y %H:%M:%S")

# Initialize graphics device
png(filename = "plot3.png", width=480, height=480)

# Create plot as shown in assignment, specify labels, sign type, color and legend 
with(hpc2, plot(hpc2$DateTime, hpc2$Sub_metering_1, type = "l", ylab="Energy sub metering", xlab=""))
lines(hpc2$DateTime, hpc2$Sub_metering_2, type = "l", col = "red")
lines(hpc2$DateTime, hpc2$Sub_metering_3, type = "l", col = "blue")
legend("topright", lty=c(1,1,1), col=c("black", "red", "blue"),c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

# Close graphics device
dev.off()
