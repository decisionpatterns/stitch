# test-stitch

library(data.table)


left <- data.table( index = letters[1:3], left_values=1:3 )  # usually fact-data
right <- data.table( index = letters[1:6], right_values=1:6 ) # usually dim-data
on="index"
gold <- right[ left, on=on ]  # WORKS

# normal data table
context( "Normal Data Table")

expect_equal( dim(gold), c(3,3) )


# ---- JOINS

context("stitch")
context(".. using 'on'")
stitched <- left %>% stitch(right, on=on)
expect_equal(stitched, gold)

context(".. natural join")
stitched <- left %>% stitch(right)
expect_equal(stitched, gold)


# ---- COL NAME COLISIONS
left <- data.table( index = letters[1:3], values=1:3 )  # usually fact-data
right <- data.table( index = letters[1:6], values=1:6 ) # usually dim-data
on="index"
# gold <- right[ left, on=c('index') ]  # WORKS


stitched <- stitch(left, right, on=on)
# expect_equal(stitched, gold)
expect_equal(stitched %>% names() %>% .[3], "right.values")


context("Name Collisions")
expect_equal(stitched %>% names(), c("index", "values", "right.values"))
