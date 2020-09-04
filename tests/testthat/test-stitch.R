# test-stitch
# test the s

library(data.table)

context("stitch")

left <- data.table( index = letters[1:3], left_values=1:3 )  # usually fact-data
right <- data.table( index = letters[1:6], right_values=1:6 ) # usually dim-data
on="index"
gold <- right[ left, on=on ] %>% setcolorder(c("index", "left_values", "right_values")) # WORKS


# Data Table ----
context( "Data Table")
expect_equal( dim(gold), c(3,3) )



# .. JOIN types ----
context(".. using 'on'")
stitched <- left %>% stitch(right, on=on)
expect_equal(stitched, gold)

context(".. natural join")
stitched <- left %>% stitch(right)
expect_equal(stitched, gold)


# Data FRAME ----
context("Data Frame")
left <- left %>% as.data.frame

context(".. using 'on'")
stitched <- left %>% stitch(right, on=on)
expect_equal(stitched, gold %>% as.data.frame() )

context(".. natural join")
left <- left %>% as.data.frame
stitched <- left %>% stitch(right)
expect_equal(stitched, gold %>% as.data.frame() )


# Column Name Collisions ----
context("Name Collisions")

left <- data.table( index = letters[1:3], values=1:3 )  # usually fact-data
right <- data.table( index = letters[1:6], values=1:6 ) # usually dim-data
on="index"

stitched <- stitch(left, right, on=on)

expect_equal(stitched %>% names() %>% .[3], "right.values")
expect_equal(stitched %>% names(), c("index", "values", "right.values"))



