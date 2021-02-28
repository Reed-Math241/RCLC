
# Require dependencies
#if(!require(tidyverse)){install.packages(tidyverse)}
# Load libraries
library(tidyverse)
library(readxl)
library(usethis)

#==========================
#     IMPORT & WRANGLE
#==========================
# Import data 
reed_checkouts <- read_excel("data-raw/Hauser_Circulation_Statistics_2018-2020.xlsx")
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
#       PYTHON SCRIPT
#==============================
# Use reticulate to run python script cleaning author names


#==============================
#       EXPORT DATASET
#==============================
# Export dataset using 'usethis'
usethis::use_data(reed_checkouts, overwrite = TRUE)
#usethis::use_r("reed_checkouts.rda") # Don't run in script! - Generates documentation script
# Try ?reed_checkouts