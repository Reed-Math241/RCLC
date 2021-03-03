
# Load dependencies 
library(openair)

# Script to generate example calendar graphic.
musing_RL <- RCLC::reed_checkouts
musing_RL$Loaned <- as.Date(musing_RL$Loaned,"%y-%m-%d")
# Filter unwanted dates
musing_RL <- musing_RL[!as.numeric(strftime(musing_RL$Loaned, "%m")) %in% 6:8,]
# Get example graphic
musing_RL %>%
  group_by(Loaned) %>%
  summarise(checkouts = n()) %>%
  rename(date=Loaned) %>%
  calendarPlot(pollutant = "checkouts", main="Library Checkouts")
