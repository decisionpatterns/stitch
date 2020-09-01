
# stitch - Safely Join and Rectangularize Data

<!-- badges: start -->
[![CRAN status](https://www.r-pkg.org/badges/version/stitch)](https://CRAN.R-project.org/package=stitch)
[![Lifecycle: maturing](https://img.shields.io/badge/lifecycle-maturing-blue.svg)](https://www.tidyverse.org/lifecycle/#maturing)
<!-- badges: end -->

The **stitch** package provides a convenient and safe LEFT JOINS mechanism for 
table-like objects. The OUTER JOINS are common in data science applications 
because building training or test tables often requires joining transaction/fact
based details with dimensional data.  

The function `stitch()` is intended to make this easy and fool proof.



## FEATURES

* Use with any table-like objects (data.frames, data.tables, tibbles)
* Pipeable
* Automatically prefix column-name collisions with the source prefix
* Column Order Preserving
* Use NATURAL JOINS (using matching column names)
* Auto Prefix of RHS names

## FUTURE:
* Idempotent: Multiple joins of the same data do not result
* Auto Prefix of LHS names

## Installation

You can install the released version of stitch from [CRAN](https://CRAN.R-project.org) with:

``` r
install.packages("stitch")
```

## Example

This is a basic example which shows you how to solve a common problem:

``` r
library(stitch)

left <- data.table( letters = letters[1:5], numbers=1:5 )
right <- data.table( lets = letters[1:6], numbers=1:6 )

left %>% stitch(right, on=c("letters"="lets" ) )
```

