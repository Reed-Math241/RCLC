<!-- README.md is generated from README.Rmd. Please edit that file -->

<!-- You'll still need to render `README.Rmd` regularly, to keep `README.md` up-to-date. `devtools::build_readme()` is handy for this.  -->

# RCLC

<!-- badges: start -->

<!-- badges: end -->

The goal of RCLC (Reed College Library Checkout) is to provide an easy-to-use and insightful dataset with clear information about book checkouts from the Hauser Memorial Library from 2018 to 2020. Each observation in this data set corresponds to a checkout!

## Installation

The development version of Reed College Library Checkout is available from
[GitHub](https://github.com/Reed-Math241/pkgGrpn) with:

``` r
# install.packages("devtools")
devtools::install_github("Reed-Math241/pkgGrpn")
```

## Example
To import our dataset, just run:
``` r
library(RCLC)

checkouts <- RCLC::reed_checkouts

# OR

checkouts <- reed_checkouts
```

Here is an example of our data in action! This is a heatmap (over a calendar) of checkout data by day. Can you think of why 2020 looks so different from 2019?

Checkouts 2019 (Redux)          |  Checkouts 2020 (Redux)
:------------------------------:|:-------------------------------:
![](Graphics/example_2019.png)  |  ![](Graphics/example_2020.png)

Each checkout comes from one of three locations: "PARC", "IMC", and "reed". To get the subset of checkouts from a single location, simply use the following function:
```{r}
get_checkouts(location = "PARC")
```

