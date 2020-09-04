#' stitch
#'
#' Safe Left-Join for training/scoring data creation
#'
#' @param lhs data; left-handed side for LEFT JOIN
#' @param rhs data; right-handed side data for LEFT JOIN
#' @param on character; join specification see [data.table::data.table()]
# @param lhs.prefix character; name derived from pipe source
#' @param rhs.prefix character; prefix for columns from the right
#'
#' @details
#'
#' `stitch` provides safe LEFT JOINS for building rectangularized tables, the
#' kind used for modeling and other analyses.  It does the following:
#'
#' 1. Supports LEFT JOINS using `on`, `key` or a NATURAL JOIN.
#' 2. Preserves column ordering, keeping LHS columns on the left.
#' 3. Handles column name collisions by auto-prefixing RHS column names with the
#'    name of the data set.
#'
#' @examples
#'
#' require(data.table)
#' left <- data.table( id = c(1,1,2,2,4), amount=1:5 )
#' right <- data.table( id = 1:6, type=letters[1:6]  )
#'
#' left %>% stitch(right)
#'
#'
#' @importFrom stringr str_replace
#' @import data.table
#' @import stringr
#' @import magrittr
#' @export


stitch <- function(lhs, rhs, on=NULL, ...)  UseMethod('stitch')

#' @rdname stitch
#' @export
stitch.data.frame <- function(lhs, rhs, on=NULL, ...) {

  ret <- stitch( lhs %>% setDT(), rhs=rhs, on=on, ...)
  as.data.frame(ret)

}


#' @rdname stitch
#' @export
stitch.data.table <- function(
                      lhs
                    , rhs
                    , on=NULL
#                    , lhs.prefix  = get_pipe_source_name(lhs)
                    , rhs.prefix = deparse( substitute(rhs) )
                  ) {


  rhs %>% setDT()

  # JOIN ----
  if( ! is.null(on) ) {                         # using `on`

    if( is.null(names(on) ) ) {                # with/out names
      on. <- on
    } else {
      on. <- structure( names(on), names=on )  # Reverse the sense of join to accomodate data.table's rhs join.
    }

    ret <- data.table:::`[.data.table`(rhs, lhs,on=on.) # rhs[ lhs, on=on. ]

  } else if( haskey(lhs) & haskey(rhs) ) {   # Using Keys
    ret <- rhs[ lhs ]                        # Keyed Join


                                                # Natural Join
  } else if( intersect( lhs %>% names, rhs %>% names ) %>% length  > 0  ) {
    on. <-intersect( lhs %>% names, rhs %>% names )
    ret <- rhs[ lhs, on=on.]

  } else {
    stop( "`on` is not provided ")

  }


  # Collided names with prefixes ----

  # * Fix `x.` prefixed columns ----  # CTB: This is not working.
  #   lhs_names.new <- ret %>% names() %>% str_replace("^x\\.", lhs.prefix %>% str_suffix('.') )
  #   ret %>% setnames( ret %>% names(), lhs_names.new )

  # * Fix `i.` collided names ----
    rhs_names.new <- ret %>% names() %>% str_replace("^i\\.", rhs.prefix %>% str_suffix('.') )
    ret %>% setnames( ret %>% names(), rhs_names.new )


  # Order Columns ----
  # order <- c(names(lhs), names(rhs) )
  ## ret %>% names %>% setdiff(order)
  # ret %>% setcolorder( rhs_names.new )
  ret %>% setcolorder( names(lhs) )
  # ret %>% setorderv( lhs_names.new %>% intersect(names(ret) ))

  ret

}




