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

## Convert the first and second sub_metering variables from factor to numeric.
new_mydata$Sub_metering_1 <- as.numeric(as.character(new_mydata$Sub_metering_1))
new_mydata$Sub_metering_2 <- as.numeric(as.character(new_mydata$Sub_metering_2))

## Creat a plot and copy to png.
#plot(x, y, type = "n")
plot(new_mydata$new_datentime, new_mydata$Sub_metering_1, type = "l", col = "Black", ylab = "Energy sub metering", xlab = "")
lines(new_mydata$new_datentime, new_mydata$Sub_metering_2, type = "l", col = "Red")
lines(new_mydata$new_datentime, new_mydata$Sub_metering_3, type = "l", col = "Blue")

legend("topright", lty = c(1,1,1), col = c("Black", "Red", "Blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), text.font = 6)
dev.copy(png, file = "plot3.png")
dev.off()
