## Read in data table, convert date, subset to Feb. 1&2, 2007, then convert time
dat <- read.table("household_power_consumption.txt", header=T, sep=";", na.strings="?")
dat$Date <- as.Date(dat$Date, format = "%d/%m/%Y")
dat <- dat[dat$Date == "2007-02-01" | dat$Date == "2007-02-02",]
dat$Time <- strftime(strptime(dat$Time, "%H:%M:%S"), "%H:%M:%S")

## Create variable containing all times across February 1st and 2nd
timeFrame <- strptime(paste(dat$Date, dat$Time, sep=" "), format="%Y-%m-%d %H:%M:%S")
## Determine maximum graph height
graphHeight <- max(c(max(dat$Sub_metering_1), max(dat$Sub_metering_2), max(dat$Sub_metering_3)))

## Create plot in 'png' image file
png(filename = "plot3.png", width=480, height=480)
plot(timeFrame, dat$Sub_metering_1, xlab="", ylab="Energy sub metering", type="l")
par(new=T)
plot(timeFrame, dat$Sub_metering_2, col="red", type="l", xlab="", ylab="", ylim=c(0,graphHeight))
par(new=T)
plot(timeFrame, dat$Sub_metering_3, col="blue", type="l", xlab="", ylab="", ylim=c(0,graphHeight))
legend("topright", c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), lty=1, col=c("black","red","blue"))
dev.off()