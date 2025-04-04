#' test utilities
#'
#' @description A test utility function
#' 
#' @param start A character string indicating the start tag. Default is `NULL`.
#' @param end A character string indicating the end tag. Default is `NULL`.
#' @param msg A character string containing the log message.
#'
#' @return The return value, if any, from executing the utility.
#'
#' @export
#' 
test_logger <- function(start = NULL, end = NULL, msg) {
  if (is.null(start) & is.null(end)) {
    cat("\n")
    cli::cli_inform("TEST:[{format(Sys.time(), '%Y-%m-%d %H:%M:%S')}] = {msg}")
  } else if (!is.null(start) & is.null(end)) {
    cat("\n")
    cli::cli_inform("\nTEST: START [{format(Sys.time(), '%Y-%m-%d %H:%M:%S')}] {start} = {msg}")
  } else if (is.null(start) & !is.null(end)) {
    cat("\n")
    cli::cli_inform("\nTEST: END [{format(Sys.time(), '%Y-%m-%d %H:%M:%S')}] {end} = {msg}")
  } else {
    cat("\n")
    cli::cli_inform("\nTEST: START [{format(Sys.time(), '%Y-%m-%d %H:%M:%S')}]{start} = {msg}")
    cat("\n")
    cli::cli_inform("\nTEST: END [{format(Sys.time(), '%Y-%m-%d %H:%M:%S')}] {end} = {msg}")
  }
}
