## Read in data table, convert date, subset to Feb. 1&2, 2007, then convert time
dat <- read.table("household_power_consumption.txt", header=T, sep=";", na.strings="?")
dat$Date <- as.Date(dat$Date, format = "%d/%m/%Y")
dat <- dat[dat$Date == "2007-02-01" | dat$Date == "2007-02-02",]
dat$Time <- strftime(strptime(dat$Time, "%H:%M:%S"), "%H:%M:%S")

## Create variable containing all times across February 1st and 2nd
timeFrame <- strptime(paste(dat$Date, dat$Time, sep=" "), format="%Y-%m-%d %H:%M:%S")
## Determine maximum graph height for the graph in row 2, column 1
graphHeight <- max(c(max(dat$Sub_metering_1), max(dat$Sub_metering_2), max(dat$Sub_metering_3)))

## Create plots in 'png' image file
png(filename = "plot4.png", width=480, height=480)
##Grid for 4 graphs
par(mfrow=c(2,2), mar=c(4,4,2,1))
##Graph in row 1, column 1
plot(timeFrame, dat$Global_active_power, xlab="", ylab="Global Active Power", type="l")
##Graph in row 1, column 2
plot(timeFrame, dat$Voltage, xlab="datetime", ylab="Voltage", type="l")
##Graph in row 2, column 1
plot(timeFrame, dat$Sub_metering_1, xlab="", ylab="Energy sub metering", type="l")
par(new=T)
plot(timeFrame, dat$Sub_metering_2, col="red", type="l", xlab="", ylab="", ylim=c(0,graphHeight))
par(new=T)
plot(timeFrame, dat$Sub_metering_3, col="blue", type="l", xlab="", ylab="", ylim=c(0,graphHeight))
legend("topright", c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), lty=1, col=c("black","red","blue"), bty="n")
##Graph in row 2, column 2
plot(timeFrame, dat$Global_reactive_power, xlab="datetime", ylab="Global_reactive_power", type="l")
dev.off()