# Load dependencies 
library(openair)
library(tidyr)
library(dplyr)
library(RCLC)


# Script to generate example calendar graphic.
# Filter unwanted dates
# Get example graphic
filtered <- reed_checkouts %>%
  filter(as.numeric(strftime(Loaned, "%m")) %in% 2:5) %>%
  group_by(Loaned) %>%
  summarise(checkouts = n()) %>%
  rename(date=Loaned)

calendarPlot(filtered,
             pollutant = "checkouts", 
             year = 2019, 
             limits = c(0, max(filtered$checkouts))) 

calendarPlot(filtered,
             pollutant = "checkouts", 
             year = 2020, 
             limits = c(0, max(filtered$checkouts))
)



