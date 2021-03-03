
#==========================
#    WRANGLING FUNCTION
#==========================

# Takes in a string of consecutive integers
.handleDATE <- function(date_str){
  str_len <- str_length(date_str)
  if(is.na(str_len)){NA} # Date has unknown decade or year
  else if(str_len == 4){substr(date_str, 1, 4)} # Date is of proper form
  else{.handleIMPROPERS(date_str)} # Date is improper, wrangle manually
}

#==========================
#       CASE HANDLING
#==========================

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
  max_yr <- 2021
  # Date is a range of dates, get years and process cases
  lw_yr <- as.numeric(.strHEAD(date_str, first_n = 4)); hi_yr <- as.numeric(.strTAIL(date_str, last_n = 4))
  # Redundant or improper range (copyright label)
  if(lw_yr == hi_yr){paste(lw_yr, sep = "")}
  # Improper ranges
  else if(lw_yr > hi_yr){
    if(lw_yr < max_yr){paste(lw_yr, sep = "")}
    else{paste(hi_yr, sep = "")}
  }
  # Proper range
  else if(lw_yr < hi_yr){
    paste(lw_yr, hi_yr, sep = "-")
  }
}

# Handles cases of messy formats
.handleUNCOMMON <- function(date_str){
  # Get length of date string
  str_len <- str_length(date_str)
  max_yr <- 2021 # Maximum possible year
  if(str_len == 5){
    candidate <- as.numeric(paste("20", .strTAIL(date_str, last_n = 2), sep = ""))
    if(candidate < max_yr){paste(candidate)}
    else{.strHEAD(date_str, first_n = 4)}
  }
  else if(str_len == 10){
    first4 <- as.numeric(.strHEAD(date_str, first_n = 4))
    paste(first4)
  }
  else if(str_len == 7 || str_len == 11){
    first4 <- as.numeric(.strHEAD(date_str, first_n = 4))
    last8 <- .strTAIL(date_str, last_n = 8)
    if(first4 > max_yr){.handleLEN8(last8)} else{paste(first4)}
  }
  else if(str_len == 12){
    first4 <- as.numeric(substr(date_str, start = 1, stop = 4))
    last8 <- .strTAIL(date_str, last_n = 8)
    if(first4 > max_yr){.handleLEN8(last8)} else{paste(first4)}
  }
  else if(str_len == 13 || str_len == 16){.handleLEN8(.strHEAD(date_str, first_n = 8))}
  else{date_str} # Edge cases
}



.handleIMPROPERS <- function(date_str){
  # Get length of date string
  str_len <- str_length(date_str)
  # Handle by case
  if(str_len == 2 || str_len == 3){.handlePARTIAL(date_str)} # Missing decade/year
  else if(str_len == 6){.handleLEN6(date_str)} # Handle strings of length 6 (19XX - 19YY)
  else if(str_len == 8){.handleLEN8(date_str)} # Date is imprecise range
  else{.handleUNCOMMON(date_str)} # Handle uncommon date formats
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
