#' Inverted versions of in, is.null and is.na
#'
#'
#' @rdname not_in
#'
#' @param x object 1
#' @param y object 2
#'
#' @examples
#' 1 %not_in% 1:10
#'
'%not_in%' <- function(x, y) {
  return( !(x %in% y) )
}

#' Inverted versions of is.null
#'
#' @rdname not_null
#'
#' @param x object
#'
not_null <- function(x) {
  !is.null(x)
}

#' Inverted versions of in is.na
#'
#' @rdname not_na
#'
#' @param x object
#'
not_na <- function(x) {
  !is.na(x)
}
#' Removes the null from a vector
#'
#'
#' @param x object
#'
#' @examples
#' drop_nulls(list(1, NULL, 2))
drop_nulls <- function(x) {
  x[!sapply(x, is.null)]
}

#' If x is `NULL`, return y, otherwise return x
#'
#' @param x,y Two elements to test, one potentially `NULL`
#'
#'
#' @name if_not_NULL
#'
#' @examples
#' NULL %||% 1
"%||%" <- function(x, y) {
  if (is.null(x)) {
    y
  } else {
    x
  }
}

#' If x is `NA`, return y, otherwise return x
#'
#' @param x,y Two elements to test, one potentially `NA`
#'
#'
#' @name if_not_NA
#'
#' @examples
#' NA %|NA|% 1
"%|NA|%" <- function(x, y) {
  if (is.na(x)) {
    y
  } else {
    x
  }
}

#' Typing reactiveValues is too long
#'
#' @param ... arguments from `shiny::reactiveValues()`
#'
#'
#'
rv <- function(...) {
  reactiveValues(...)
}

#' Typing reactiveValuesToList is too long
#'
#' @param ... arguments from `shiny::reactiveValuesToList()`
#'
#'
#'
rvtl <- function(...) {
  reactiveValuesToList(...)
}
