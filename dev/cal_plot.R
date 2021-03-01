
# Script to generate calendar graphic.
musing_RL <- read_csv("../data/RCLC.csv")
musing_RL$Loaned <- as.Date(musing_RL$Loaned,"%y-%m-%d")
musing_RL <- musing_RL[!as.numeric(strftime(musing_RL$Loaned, "%m")) %in% 6:8,]

musing_RL %>%
  group_by(Loaned) %>%
  summarise(checkouts = n()) %>%
  rename(date=Loaned) %>%
  calendarPlot(pollutant = "checkouts",
               #year = 2020, 
               main="Library Checkouts")
