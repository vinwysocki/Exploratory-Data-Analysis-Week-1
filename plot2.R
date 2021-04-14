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


plot_Data           <- tibble(as.numeric(filtered_data$Global_active_power))
colnames(plot_Data) <- "Global_active_power"
plot_Data$Time                  <- paste_time
plot(plot_Data$Time, plot_Data$Global_active_power, type = "S" , ylab = "Global Active Power (kilowatts)", xlab = "", main = "Plot 2")



dev.copy(png, file = "plot2.png", width = 480, height = 480,)
dev.off()


