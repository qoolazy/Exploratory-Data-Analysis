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
png(filename = "plot1.png", width=480, height=480)

# Create histogram as shown in assignment, specify labels, color and size of a histogram 
hist(hpc2$Global_active_power, 
     xlab="Global Active Power (killowatts)", 
     main="Global Active Power", 
     col="red", 
     ylim=c(0,1200)
     )

# Close graphics device
dev.off()
