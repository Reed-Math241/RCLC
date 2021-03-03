
<!-- README.md is generated from README.Rmd. Please edit that file -->
<!-- You'll still need to render `README.Rmd` regularly, to keep `README.md` up-to-date. `devtools::build_readme()` is handy for this.  -->

# RCLC

<!-- badges: start -->
<!-- badges: end -->

The goal of RCLC (Reed College Library Checkout) is to provide an
easy-to-use and insightful dataset with clear information about book
checkouts from the Hauser Memorial Library from 2018 to 2020. Each
observation in this data set corresponds to a checkout!

## Installation

The development version of Reed College Library Checkout is available
from [GitHub](https://github.com/Reed-Math241/pkgGrpn) with:

``` r
# install.packages("devtools")
devtools::install_github("Reed-Math241/pkgGrpn")
```

## Example

To import our dataset, just run:

``` r
library(RCLC)
# Sourcing the data directly from the package
checkouts <- reed_checkouts # Also possible to use RCLC::reed_checkouts
```

Or alternatively, use the built-in `get_checkouts` function:

``` r
library(RCLC)
# Using the package function
checkouts <- get_checkouts() # Default value returns entire dataset, no argument needed
```

Here is an example of our data in action! This is a heatmap (over a
calendar) of checkout data by day. Can you think of why 2020 looks so
different from 2019?

|     Checkouts 2019 (Redux)     |     Checkouts 2020 (Redux)     |
|:------------------------------:|:------------------------------:|
| ![](Graphics/example_2019.png) | ![](Graphics/example_2020.png) |

The three facilities in which Reedies could checkout resources are the
IMC, PARC, and the Hauser Library. To get the checkouts data for the IMC
or the PARC, simply use the following function:

``` r
# Get PARC checkout data
PARC_checkouts <- RCLC::get_checkouts(location = "PARC")
# Get IMC checkout data
IMC_checkouts <- RCLC::get_checkouts(location = "IMC")
```

The `get_checkouts` function is versatile! You could also query
substrings of checkout locations to get various filterings of the
checkout data. Consider the following code, where the user obtains
musical score checkouts:

``` r
# Get musical score checkout data
score_checkouts <- RCLC::get_checkouts(location = "Score")
```
