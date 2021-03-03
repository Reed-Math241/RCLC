
#=================================================================================#
#                              GET_CHECKOUTS FUNCTION
#=================================================================================#

#' @title Obtain checkout data matching a given location substring
#'
#' @description Returns a filtered reed_checkouts dataset matching a location substring
#'
#' @param location A location substring that filters the reed_checkouts with a location string containing the substring.
#'
#' @return A checkouts dataframe.
#' @examples
#' # Get original dataset
#' reed_checkouts <- get_checkouts()
#' 
#' # Get PARC checkouts
#' PARC_checkouts <- get_checkouts(location = "PARC")
#'
#' # Get IMC checkouts
#' IMC_checkouts <- get_checkouts(location = "IMC")
#' 
#' # Get musical score checkouts
#' score_checkouts <- get_checkouts(location = "score")
#' 
get_checkouts <- function(location = NA){
  if(is.na(location)){return(RCLC::reed_checkouts)} # Default value
  if(class(location) != "character"){stop("Please input a string with a valid location substring.")}
  # Get location factor vector
  locs_vec <- as.character(levels(as.factor(RCLC::reed_checkouts$Location)))
  # Get locations that match location string
  loc_matches <- locs_vec[grep(pattern = location, x = locs_vec)]
  if(length(loc_matches) == 0){warning("Your query returned no location matches. Please check your substring and try again.")}
  # Return rows in those locations
  RCLC::reed_checkouts[which(RCLC::reed_checkouts$Location %in% loc_matches),]
}