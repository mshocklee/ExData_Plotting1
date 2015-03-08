## Read in data table, convert date, subset to Feb. 1&2, 2007, then convert time
dat <- read.table("household_power_consumption.txt", header=T, sep=";", na.strings="?")
dat$Date <- as.Date(dat$Date, format = "%d/%m/%Y")
dat <- dat[dat$Date == "2007-02-01" | dat$Date == "2007-02-02",]
dat$Time <- strftime(strptime(dat$Time, "%H:%M:%S"), "%H:%M:%S")

## Create variable containing all times across February 1st and 2nd
timeFrame <- strptime(paste(dat$Date, dat$Time, sep=" "), format="%Y-%m-%d %H:%M:%S")

## Create plot in 'png' image file
png(filename = "plot2.png", width=480, height=480)
plot(timeFrame, dat$Global_active_power, xlab="", ylab="Global Active Power (kilowatts)", type="l")
dev.off()