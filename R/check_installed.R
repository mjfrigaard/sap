#' Check if package is installed
#' 
#' @description
#' An example function for demonstrating how to use `testthat`'s
#' mocking functions.
#' 
#' @param package string, name of package
#'
#' @return invisible 
#'
#' @importFrom rlang is_installed
#'
#' @export
#'
#' @examples
#' check_installed("foo")
#' check_installed("base")
check_installed <- function(package) {
  if (is_installed(package)) {
    return(invisible())
  } else {
    stop("Please install '{package}' before continuing")
  }
}