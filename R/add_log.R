#' Log Messages to Console and Optional File
#'
#' A utility function for logging messages to the console and optionally
#' to a specified log file using the `logger` package.
#' This function supports multiple log levels, including `INFO`, `DEBUG`,
#' `WARN`, and `ERROR`.
#'
#' @param message A character string representing the message to be logged.
#' @param level A character string indicating the log level. One of "`FATAL`",
#' `"ERROR"`, `"WARN"`, `"SUCCESS"`, `"INFO"`, `"DEBUG"`, or "`TRACE`".
#' Defaults to `"INFO"`.
#' @param log_file A character string specifying the path to the log file. 
#' Defaults to `NULL` (messages not written to a file).
#'
#' @details
#' - This function uses the `logger` package to manage logging.
#' - By default, all log messages are printed to the console.
#' - If `log_file` is specified, log messages are also written to the 
#'   specified file.
#' - The `log_formatter` uses the `formatter_glue` format for interpolating
#'   variables in the log message.
#'
#' @return
#' This function does not return a value; it is used for its side effect of 
#' logging messages.
#' 
#' @family **Utility Functions**
#'
#' @examples
#' # Log an informational message
#' add_log(message = "Application started.")
#'
#' # Log a debug message to both console and file
#' add_log(message = "Debugging variable x.", level = "DEBUG", log_file = "debug_log.txt")
#'
#' # Log a warning message without saving to a file
#' add_log(message = "Potential issue detected.", level = "WARN", log_file = NULL)
#'
#' # Log an error message to a specific file
#' add_log(message = "An error occurred.", level = "ERROR", log_file = "errors_log.txt")
#'
#' @seealso
#' - [`logger::log_appender()`] for customizing log destinations.
#' - [`logger::log_formatter()`] for customizing log message formats.
#' - [`logger::log_info()`], [`logger::log_debug()`], [`logger::log_warn()`], [`logger::log_error()`] for log level-specific functions.
#'
#' @export
add_log <- function(message, level = "INFO", log_file = NULL) {
  
  logger::log_appender(logger::appender_console)
  
  if (!is.null(log_file)) {
    logger::log_appender(logger::appender_tee(log_file))
  }
  
  logger::log_formatter(logger::formatter_glue)
  
  switch(
    level,
    "FATAL" = logger::log_fatal("{message}"),
    "ERROR" = logger::log_error("{message}"),
    "WARN" = logger::log_warn("{message}"),
    "SUCCESS" = logger::log_success("{message}"),
    "INFO" = logger::log_info("{message}"),
    "DEBUG" = logger::log_debug("{message}"),
    "TRACE" = logger::log_trace("{message}"),
    logger::log_info("{message}") 
  )
}
