#' Test logger (test utility)
#' 
#' Verbose test output
#' 
#' @param msg test message 
#' @param start test start message 
#' @param end test end message 
#'
#' @return message to test output
#'
test_logger <- function(msg, start = NULL, end = NULL) {
  if (is.null(start) & is.null(end)) {
    cat("\n")
    logger::log_info("{msg}")
  } else if (!is.null(start) & is.null(end)) {
    cat("\n")
    logger::log_info("\n[ START {start} = {msg}]")
  } else if (is.null(start) & !is.null(end)) {
    cat("\n")
    logger::log_info("\n[ END {end} = {msg}]")
  } else {
    cat("\n")
    logger::log_info("\n[ START {start} = {msg}]")
    cat("\n")
    logger::log_info("\n[ END {end} = {msg}]")
  }
}