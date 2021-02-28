musing_RL <- read_csv("data/RCLC.csv")

musing_RL$Loaned <- as.Date(musing_RL$Loaned,"%y-%m-%d")

musing_RL <- musing_RL[!as.numeric(strftime(musing_RL$Loaned, "%m")) %in% 6:8,]



musing_RL %>%
  group_by(Loaned) %>%
  summarise(checkouts = n()) %>%
  rename(date=Loaned) %>%
  #filter(date>"2019-05-01") %>%
  calendarPlot(pollutant = "checkouts",
               #year = 2020, 
               main="Library Checkouts")
