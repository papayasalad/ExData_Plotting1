power_con <- read.table("./household_power_consumption.txt", header = TRUE, sep = ";", na.strings = "NA")
power_con$Date <- as.Date(power_con$Date, "%d/%m/%Y")
mydata <- power_con[(power_con$Date == "2007-02-01" | power_con$Date == "2007-02-02"), ]

## Paste Date and Time, note that paste function can only read character arguments. 
datentime <- paste(as.character(mydata$Date), as.character(mydata$Time))
## Load lubridate, parse Date and Time.
library(lubridate)
new_datentime <- ymd_hms(datentime)
## Add new column that combine date and time to previous data frame.
new_mydata <- cbind(mydata, new_datentime)

## Convert the following five variables from factor to numeric.
new_mydata$Global_active_power <- as.numeric(as.character(new_mydata$Global_active_power))
new_mydata$Global_reactive_power <- as.numeric(as.character(new_mydata$Global_reactive_power))
new_mydata$Voltage <- as.numeric(as.character(new_mydata$Voltage))
new_mydata$Sub_metering_1 <- as.numeric(as.character(new_mydata$Sub_metering_1))
new_mydata$Sub_metering_2 <- as.numeric(as.character(new_mydata$Sub_metering_2))

## Make a plot comprised of four sub-plots. 
par(mfrow = c(2,2), mar = c(4,4,2,1), oma = c(0, 0, 2, 0))
with(new_mydata, {
  plot(new_datentime, Global_active_power, type = "l", ylab = "Global active power", xlab = "")
  plot(new_datentime, Voltage, type = "l", ylab = "Voltage", xlab = "datetime")
  plot(new_datentime, Sub_metering_1, type = "l", col = "Black", ylab = "Energy sub metering", xlab = "")
  lines(new_datentime, Sub_metering_2, type = "l", col = "Red")
  lines(new_datentime, Sub_metering_3, type = "l", col = "Blue")
  legend("topright", lty = c(1,1,1), col = c("Black", "Red", "Blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), bty = "n", text.font = 6, cex = 0.6)
  plot(new_datentime, Global_reactive_power, type = "l", ylab = "Global_reactive_power", xlab = "datetime")
  })
dev.copy(png, file = "plot4.png")
dev.off()
