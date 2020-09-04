
# stitch - Safely Join and Rectangularize Data

<!-- badges: start -->
[![CRAN status](https://www.r-pkg.org/badges/version/stitch)](https://CRAN.R-project.org/package=stitch)
[![Lifecycle: maturing](https://img.shields.io/badge/lifecycle-maturing-blue.svg)](https://www.tidyverse.org/lifecycle/#maturing)
<!-- badges: end -->

The **stitch** package provides convenient and safe LEFT JOINS for 
table-like objects. LEFT JOINS are commonly used in data science applications 
when combining transaction/fact-based details with 
dimensional data. 

## FEATURES

The function `stitch()` is intended to make this easy and fool-proof. It is a 
pipeable function, that works on any table-like object.

* Use with any table-like objects (data.frames, data.tables, tibbles)
* Pipeable
* Column Order Preserving
* Use NATURAL JOINS (using matching column names)
* Automatically handling name-collisions by auto prefix collisions with RHS name


1. Supports LEFT JOINS using `on`, `key` or a NATURAL JOIN.
2. Preserves column ordering, keeping LHS names on the left.
3. Handles column name collisions by auto-prefixing RHS column names with the
    name of the data set.

## FUTURE(?)
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

