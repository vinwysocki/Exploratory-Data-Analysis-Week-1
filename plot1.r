library(tidyverse)
library(lubridate) 

my_data <- read.table("household_power_consumption.txt", sep = ";", header = TRUE)

filtered_data <- my_data %>% filter(Date == "1/2/2007" | Date == "2/2/2007") %>% 
                             filter(Global_active_power != "?") %>% 
                             select(1:9)

filtered_data$Global_active_power <- as.numeric(filtered_data$Global_active_power)


hist(filtered_data$Global_active_power,
     col = "Red", 
     xlab = "Global Active Power (kilowatts)",
     main = "Global Active Power"
)


dev.copy(png, file = "plot1.png", width = 480, height = 480,)
dev.off()


