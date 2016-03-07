power_con <- read.table("./household_power_consumption.txt", header = TRUE, sep = ";", na.strings = "NA")

## Convert Date variable using as.Date function.
power_con$Date <- as.Date(power_con$Date, "%d/%m/%Y")
## Subset data frame by selecting rows with Date equal to "2007-02-01" or "2007-02-02".
mydata <- power_con[(power_con$Date == "2007-02-01" | power_con$Date == "2007-02-02"), ]

## Make a plot, note that Global_active_power is a factor, so it has to be changed to numeric first. 
hist(as.numeric(as.character(mydata$Global_active_power)), col = "Red", xlab = "Global Active Power (kilowatts)", main = "Global Active Power")
dev.copy(png, file = "plot1.png")
dev.off()