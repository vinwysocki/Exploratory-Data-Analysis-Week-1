library(tidyverse)
library(lubridate)

my_data <- read.table("household_power_consumption.txt", sep = ";", header = TRUE)

filtered_data <- my_data %>% filter(Date == "1/2/2007" | Date == "2/2/2007") %>% 
        filter(Global_active_power != "?") %>% 
        select(1:9)


Date <- filtered_data$Date
Time <- filtered_data$Time
Date <- gsub("/","-", Date) 
Date <- format(as.Date(Date,format="%d-%m-%Y"),format="%y-%m-%d")
paste_time      <- as.POSIXct(paste(Date, Time), format="%Y-%m-%d %H:%M:%S")

remove(plot_Data)

plot_Data                       <- tibble(as.numeric(filtered_data$Global_active_power))
plot_Data$Global_reactive_power <- filtered_data$Global_reactive_power
colnames(plot_Data)[1:2] <- c("Global_reactive_power", "Global_active_power")

plot_Data$Time                  <- paste_time
plot_Data$Voltage               <- filtered_data$Voltage

plot_Data$Sub_metering_1 <- filtered_data$Sub_metering_1
plot_Data$Sub_metering_2 <- filtered_data$Sub_metering_2
plot_Data$Sub_metering_3 <- filtered_data$Sub_metering_3




par(mfrow = c(2, 2), mar = c(4, 2, 2, 4), oma = c(2, 2, 2, 2))

plot(plot_Data$Time, plot_Data$Global_active_power, type = "S" , ylab = "Global Active Power", xlab = "")
mtext(las= 1, side = 2, line = 0, at=0.6, "Plot 4", cex = 1)
plot(plot_Data$Time, plot_Data$Voltage, type = "S" , xlab = "datetime", ylab = "Voltage")

plot(plot_Data$Time, plot_Data$Sub_metering_1, type = "S" , ylab = "Energy sub metering", xlab = "")
lines(plot_Data$Time, plot_Data$Sub_metering_2, col = "Red")
lines(plot_Data$Time, plot_Data$Sub_metering_3, col = "Blue")
legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       col=c("black", "red", "blue"),lty = 1, bty = "n")

plot(plot_Data$Time, plot_Data$Global_reactive_power, type = "S" , xlab = "datetime", ylab = "Global_reactive_power")


dev.copy(png, file = "plot4.png", width = 480, height = 480,)
dev.off()
