library(tidyverse)
library(lubridate)

my_data <- read.table("household_power_consumption.txt", sep = ";", header = TRUE)

filtered_data <- my_data %>% filter(Date == "1/2/2007" | Date == "2/2/2007") %>% 
        filter(Global_active_power != "?") %>% 
        select(1:9)


Date <- filtered_data$Date
Time <- filtered_data$Time
Date <- gsub("/","-", Date) 
Date <- format(as.Date(Date,format="%d-%m-%Y"), format="%y-%m-%d")
paste_time      <- as.POSIXct(paste(Date, Time), format="%Y-%m-%d %H:%M:%S")

plot_Data                <- tibble(paste_time)
colnames(plot_Data)      <- "Time"
plot_Data$Sub_metering_1 <- filtered_data$Sub_metering_1
plot_Data$Sub_metering_2 <- filtered_data$Sub_metering_2
plot_Data$Sub_metering_3 <- filtered_data$Sub_metering_3


plot(plot_Data$Time, plot_Data$Sub_metering_1, type = "S" , ylab = "Energy sub metering", xlab = "", main = "Plot 3")
lines(plot_Data$Time, plot_Data$Sub_metering_2, col = "Red")
lines(plot_Data$Time, plot_Data$Sub_metering_3, col = "Blue")
legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       col=c("black", "red", "blue"),lty = 1, cex = 1.5)

dev.copy(png, file = "plot3.png", width = 480, height = 480,)
dev.off()
