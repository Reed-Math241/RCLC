
# Copy and paste final code onto DATASET.R

# Require dependencies
if(!require(tidyverse)){install.packages(tidyverse)}
# Load libraries
library(tidyverse)
library(reticulate)
library(readxl)


#==========================
#     IMPORT & WRANGLE
#==========================
## Import data 
reed_checkouts <- read_excel("dev/Hauser_Circulation_Statistics_2018-2020.xlsx")
## Rename variables
colnames(reed_checkouts) <- c("Title", "Author", "Published", "Location", "Barcode", "Call_No",
                              "Copies","Loaned", "Returned", "Patron")
### Create new variables
## Senior Thesis: A new boolean indicating checkout is a senior thesis
reed_checkouts$Thesis <- reed_checkouts$Call_No=="Thesis"
## Remove unwanted columns
reed_checkouts <- subset(reed_checkouts, select = -c(Barcode))#, Call_No))

#==========================
#      CLEAN COLUMNS
#==========================
# Clean publication date column (Remove copyright symbols, periods, and multiple dates)
reed_checkouts$Published <- gsub("[^0-9]", "", reed_checkouts$Published)
reed_checkouts$Published <- substr(reed_checkouts$Published, 1, 4)
# Clean title column
reed_checkouts$Title <- gsub('[/]{1}$', '', reed_checkouts$Title) #regex heckery

#==============================
#      TEMPORARY EXPORT
#==============================
# Write a csv file for further interim wrangling
#write_csv(reed_checkouts, "../dev/RCLC.csv")
