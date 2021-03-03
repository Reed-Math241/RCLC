
# Copy and paste final code onto DATASET.R

# Require dependencies
if(!require(tidyverse)){install.packages(tidyverse)}
# Load libraries
library(tidyverse)
library(readxl)
source("../R/pubdate.R")

#==========================
#     IMPORT & WRANGLE
#==========================

## Import data 
reed_checkouts <- read_excel(path = "Hauser_Circulation_Statistics_2018-2020.xlsx") 
## Rename variables
colnames(reed_checkouts) <- c("Title", "Author", "PubDate", "Location", "Barcode", "Call_No", "Copies", "Loaned", "Returned", "Patron")

# Remove unwanted variables (Barcode)
reed_checkouts <- subset(reed_checkouts, select = -c(Barcode))

# Create Thesis column: a boolean variable indicating checkout is a senior thesis
reed_checkouts$Thesis <- (reed_checkouts$Call_No == "Thesis")
# Set NAs to false (no call numbers => not a thesis)
reed_checkouts[which(is.na(reed_checkouts$Thesis)), "Thesis"] <- FALSE 

#==========================
#      CLEAN COLUMNS
#==========================

# Clean publication date column (Remove copyright symbols, periods, and collapse multiple dates)
reed_checkouts$PubDate <- gsub("[^0-9]", "", reed_checkouts$PubDate)
# Use helper function to 
reed_checkouts$PubDate <- purrr::map_chr(reed_checkouts$PubDate, .handleDATE)
# Create date range column
reed_checkouts$PubDateRange <- reed_checkouts$PubDate
# Make non-tentative publishing dates numeric
reed_checkouts$PubDate <- as.numeric(reed_checkouts$PubDate)
# Get rows with uncertain publishing dates
certain_dates <- which(!is.na(reed_checkouts$PubDate))
# Make certain dates in range column NA
#reed_checkouts$PubDateRange[certain_dates] <- NA

# Clean title column
reed_checkouts$Title <- gsub('[/]{1}$', '', reed_checkouts$Title) # Regex heckery

# Reorder columns (moving PublDate_Range next to PublDate)
reed_checkouts <- reed_checkouts[,c(1,2,3,11,4,5,6,7,8,9,10)]

#==============================
#      TEMPORARY EXPORT
#==============================

# Write a csv file for further interim wrangling
write_csv(reed_checkouts, "RCLC.csv")
