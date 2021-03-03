
# Load libraries
library(tidyverse)
library(readxl)
library(usethis)
# Wrangling helper functions for Publication Date cleanig
#source("../R/pubdate.R")

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
#       EXPORT DATASET
#==============================
# Export dataset using 'usethis'
usethis::use_data(reed_checkouts, overwrite = TRUE)
#usethis::use_r("reed_checkouts.rda") # Don't run in script! - Generates documentation script
# Try ?reed_checkouts


#=====================================================
#              WRANGLING HELPER FUNCTION
#=====================================================

# Takes in a string of consecutive integers from collapsing the date column and parse it 
.handleDATE <- function(date_str){
  str_len <- str_length(date_str)
  if(is.na(str_len)){NA} # Date has unknown decade or year
  else if(str_len == 4){substr(date_str, 1, 4)} # Date is of proper form
  else{.handleIMPROPERS(date_str)} # Date is improper, wrangle manually
}

#==========================
#       CASE HANDLING
#==========================

# Handles improper year formats (with more or less than 4 numbers)
.handleIMPROPERS <- function(date_str){
  # Get length of date string
  str_len <- str_length(date_str)
  # Handle by common cases first
  if(str_len == 2 || str_len == 3){.handlePARTIAL(date_str)} # Missing decade/year
  else if(str_len == 6){.handleLEN6(date_str)} # Handle strings of length 6 (YYAA - BB)
  else if(str_len == 8){.handleLEN8(date_str)} # Date is of imprecise range (YYYY - YYYY)
  else{.handleUNCOMMON(date_str)} # Handle uncommon date formats
}

# Handles dates with either a missing year (YYYx) or missing decade (YYxx)
.handlePARTIAL <- function(date_str){
  str_len <- str_length(date_str)
  # Missing year
  if(str_len == 2){paste(paste(date_str,c("00","99"),sep=""), collapse = "-")}
  # Missing decade
  else if(str_len == 3){paste(paste(date_str,c("0","9"),sep=""), collapse = "-")}
}

# Handles dates of format (AAXX-AAYY) or format (NN [YYYY])
.handleLEN6 <- function(date_str){
  # First, extract the last 4 numbers to see if this is a brand year type string
  last4 <- as.numeric(.strTAIL(date_str, last_n = 4))
  # Improper year type, instead, this is of form 19AB - 19CD.
  if(last4 < 1900 || last4 > 2020){
    century <- substr(date_str, 1, 2)
    lwr_yr <- substr(date_str, 3, 4); upr_yr <- substr(date_str, 5, 6)
    if(as.numeric(lwr_yr) > as.numeric(upr_yr)){paste(century, lwr_yr, sep = "")} 
    else{paste(century, lwr_yr, "-", century, upr_yr, sep = "")}
  } 
  # Otherwise, of form XX [YYYY]
  else{paste(last4)}
}

# Handles dates of format (XXXX-YYYY)
.handleLEN8 <- function(date_str){
  # If this function is called from other function, it may be a numeric
  if(class(date_str) == "numeric"){date_str <- as.character(date_str)} 
  # Date is a range of dates, get years and process cases
  lw_yr <- as.numeric(.strHEAD(date_str, first_n = 4)); hi_yr <- as.numeric(.strTAIL(date_str, last_n = 4))
  # Redundant or improper range (copyright label in the same year)
  if(lw_yr == hi_yr){paste(lw_yr, sep = "")}
  # Improper range of dates (usually copyright dates)
  else if(lw_yr > hi_yr){
    max_yr <- 2021 # Cannot exceed max year
    if(lw_yr < max_yr){paste(lw_yr, sep = "")}
    else{paste(hi_yr, sep = "")}
  }
  # Proper range of dates
  else if(lw_yr < hi_yr){
    paste(lw_yr, hi_yr, sep = "-")
  }
}

# Handles cases of messy formats
.handleUNCOMMON <- function(date_str){
  # Set useful parameters
  str_len <- str_length(date_str) # Get length of date string
  max_yr <- 2021 # Maximum possible year
  # Get the relevant substrings for handling the cases (improves code readability)
  last2 <- as.numeric(.strTAIL(date_str, last_n = 2))
  first4 <- as.numeric(.strHEAD(date_str, first_n = 4))
  first8 <- as.numeric(.strHEAD(date_str, first_n = 8))
  last8 <- as.numeric(.strTAIL(date_str, last_n = 8))
  # Handle by case length manually
  # Note: this wrangling was done specifically for this dataset.
  # Please check the results of these wrangling functions if new improper dates are added.
  if(str_len == 5){
    candidate <- as.numeric(paste("20", last2, sep = ""))
    if(candidate < max_yr){paste(candidate)}
    else{paste(first4)}
  }
  else if(str_len == 10){paste(first4)}
  else if(str_len %in% c(7, 11, 12)){if(first4 > max_yr){.handleLEN8(last8)} else{paste(first4)}}
  else if(str_len == 13 || str_len == 16){.handleLEN8(first8)}
  else{date_str} # Edge cases
}

#==========================
#     HELPER FUNCTIONS
#==========================

# Returns string with the first n characters
.strHEAD <- function(str, first_n){
  substr(str, start = 1, stop = first_n)
}
# Returns string with the last n characters
.strTAIL <- function(str, last_n){
  l <- str_length(str) # Get length of string
  substr(str, start = l - last_n + 1, stop = l)
}
