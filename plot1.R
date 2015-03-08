## Read in data table, convert date, subset to Feb. 1&2, 2007, then convert time
dat <- read.table("household_power_consumption.txt", header=T, sep=";", na.strings="?")
dat$Date <- as.Date(dat$Date, format = "%d/%m/%Y")
dat <- dat[dat$Date == "2007-02-01" | dat$Date == "2007-02-02",]
dat$Time <- strftime(strptime(dat$Time, "%H:%M:%S"), "%H:%M:%S")

## Create plot in 'png' image file
png(filename = "plot1.png", width=480, height=480)
hist(dat$Global_active_power, col="red", main="Global Active Power", xlab="Global Active Power (kilowatts)", ylim=c(0,1200))
dev.off()