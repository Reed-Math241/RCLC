#' Reed College Library Checkouts (2018-2020)
#' 
#' Checkout data from the Reed College Library from 8/1/2018 to 7/30/20.  
#' 
#' @docType data
#' @name reed_checkouts
#' @usage reed_checkouts
#' @format  A data frame with Reed Collge Library checkout data
#' \itemize{
#' \item{\code{Title}}{ The title of the book loaned}
#' \item{\code{Author}}{ The author of the book and their birthdate}
#' \item{\code{Publishing date}}{ The date book was published}
#' \item{\code{Location}}{ The location of the library checkout/loan}
#' \item{\code{Call_No}}{ Internal Reed Call number}
#' \item{\code{Copies}}{ Copies of book available}
#' \item{\code{Loaned}}{ Beginning date of checkout}
#' \item{\code{Returned}}{ Ending date of checkout}
#' \item{\code{Patron}}{ Patron of checkout}
#' \item{\code{Thesis}}{ Senior thesis indicator}
#' }
#' @source 
#' Data provided by Mahria Lebow, Reed College Data Librarian.
"reed_checkouts"