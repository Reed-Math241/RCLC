#' Reed College Library Checkouts (2018-2020)
#' 
#' Checkout data from the Reed College Library (and other facilities) from 8/1/2018 to 7/30/20.  
#' 
#' @docType data
#' @name reed_checkouts
#' @usage reed_checkouts
#' @format  A tidy data frame with Reed College checkout data
#' \itemize{
#' \item{\code{Title}}{ The title of the item loaned}
#' \item{\code{Author}}{ The author or brand of the checked out item}
#' \item{\code{PubDate}}{ The year the item was published/released}
#' \item{\code{PubDateRange}}{ The range of years in which the item was released (when PubDate is unavailable)}
#' \item{\code{Location}}{ The location in which the checkout/loan occured}
#' \item{\code{Call_No}}{ Internal Reed Call number}
#' \item{\code{Copies}}{ Number of copies of the item available}
#' \item{\code{Loaned}}{ Loan begin date}
#' \item{\code{Returned}}{ Loan end date}
#' \item{\code{Patron}}{ Patron of checkout}
#' \item{\code{Thesis}}{ Senior thesis indicator}
#' }
#' @source 
#' Data provided by Mahria Lebow, Reed College Data Librarian.
"reed_checkouts"