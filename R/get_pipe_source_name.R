#' get_pipe_source_name (non-exported)
#'
#' Get the name from the object at the front of a pipe.
#'
#' @param data; data.frame-like object
#'
#'
#' @references
#' [Stackoverflow](https://stackoverflow.com/a/58540131/1504321)
#'
#' @examples
#'
#' my_dt <- data.table(letters=letters[1:5])
#' fun <- function(data) {
#'   # browser()
#'   get_orig_name()
#'   # data
#' }
#'
#'
#' my_dt %>% get_pipe_source_name()
#' my_dt %>% fun()
#'
#' # Not Exported

get_pipe_source_name <- function(df){
    i <- 1
    while( !("chain_parts" %in% ls(envir=parent.frame(i))) &&
           i < sys.nframe() ) {
        i <- i+1
    }
    # list(name = deparse(parent.frame(i)$lhs), output = df)
    deparse(parent.frame(i)$lhs)
}
