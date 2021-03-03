
# Load libraries
library(tidyverse)
library(readxl)
library(usethis)
# Wrangling helper functions for Publication Date cleaning
source("R/pubdate.R")

#==========================
#     IMPORT & WRANGLE
#==========================

## Import data 
reed_checkouts <- readxl::read_excel(path = "data-raw/Hauser_Circulation_Statistics_2018-2020.xlsx")
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
# Use helper function to clean publishing dates/date ranges 
reed_checkouts$PubDate <- purrr::map_chr(reed_checkouts$PubDate, .handleDATE)
# Copy date range column
reed_checkouts$PubDateRange <- reed_checkouts$PubDate
# Make non-tentative publishing dates numeric
reed_checkouts$PubDate <- as.numeric(reed_checkouts$PubDate)

# Handle proper (numeric) publishing dates
range_dates <- which(str_length(reed_checkouts$PubDate) != 4)
reed_checkouts$PubDate[range_dates] <- NA_character_ # Set date ranges to NA in numeric column (to coerce into numeric)
reed_checkouts$PubDate <- as.numeric(reed_checkouts$PubDate) # Coerce numeric
# Hand improper (character) date ranges
proper_dates <- which(!is.na(reed_checkouts$PubDate)) # Set proper dates to NA in range column (to avoid repetition)
reed_checkouts$PubDateRange[proper_dates] <- NA # Distinguish range and proper date columns 

# Clean title column
reed_checkouts$Title <- gsub('[/]{1}$', '', reed_checkouts$Title) # Regex heckery

# Reorder columns (moving PublDate_Range next to PublDate)
reed_checkouts <- reed_checkouts[,c(1,2,3,11,4,5,6,7,8,9,10)]

#==============================
#       EXPORT DATASET
#==============================

# Export dataset using 'usethis'
usethis::use_data(reed_checkouts, overwrite = TRUE)

# usethis::use_r("reed_checkouts.rda") # Don't run in script! - Generates documentation script
# Try ?reed_checkouts once this file is sourced and dataset .Rda is written.

