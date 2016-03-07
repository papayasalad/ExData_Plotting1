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

## Convert variable "Global_active_power" from factor to numeric.
new_mydata$Global_active_power <- as.numeric(as.character(new_mydata$Global_active_power))

## Creat a plot and copy to png.
plot(new_mydata$new_datentime, new_mydata$Global_active_power, type = "l", ylab = "Global active power (kilowatts)", xlab = "")
dev.copy(png, file = "plot2.png")
dev.off()
