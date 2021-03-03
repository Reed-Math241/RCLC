
# Obtain the checkout data matching a given location substring
get_checkouts <- function(location){
  if(class(location) != "character"){stop("Please input a string with a valid location factor substring.")}
  # Get location factor vector
  locs_vec <- as.character(levels(as.factor(reed_checkouts$Location)))
  # Get locations that match location string
  loc_matches <- locs_vec[grep(pattern = location, x = locs_vec)]
  if(length(loc_matches) == 0){warning("Your query returned no location matches. Please check your substring and try again.")}
  # Return rows in those locations
  reed_checkouts[which(reed_checkouts$Location %in% loc_matches),]
}