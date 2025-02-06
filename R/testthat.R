#' Log test messages (helper)
#'
#' `test_logger()` logs informational messages using the `cli` package. It 
#' allows optional `start` and `end` tags to indicate the beginning and end of
#' a process.
#'
#' @param start A character string indicating the start tag. Default is `NULL`.
#' @param end A character string indicating the end tag. Default is `NULL`.
#' @param msg A character string containing the log message.
#'
#' @details
#' - If both `start` and `end` are `NULL`, logs only the message.
#' - If `start` is provided and `end` is `NULL`, logs a message prefixed with 
#' `START <start> = <msg>`.
#' - If `start` is `NULL` and `end` is provided, logs a message prefixed with 
#' `END <end> = <msg>`.
#' - If both `start` and `end` are provided, logs both `START` and `END`
#'  messages.
#'
#' @return Logs messages and returns `NULL` (used for side effects).
#'
#' @examples
#' test_logger(msg = "Processing started")
#' test_logger(start = "Step1", msg = "Loading data")
#' test_logger(end = "Step1", msg = "Data loaded successfully")
#' test_logger(start = "Step2", end = "Step2", msg = "Performing computation")
#'
#' @keywords internal
#' 
#' @export
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
