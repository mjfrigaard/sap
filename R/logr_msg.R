#' Log Messages to Console and File with Optional JSON Format
#'
#' A utility function for logging messages to the console and optionally to a
#' log file. Messages can be stored as plain text (default) or in JSON format.
#' Additionally, logging to a file can be disabled altogether.
#'
#' @param message A character string representing the message to be logged.
#' @param level A character string indicating the log level. One of:
#'   - `"FATAL"`
#'   - `"ERROR"`
#'   - `"WARN"`
#'   - `"SUCCESS"`
#'   - `"INFO"` (default)
#'   - `"DEBUG"`
#'   - `"TRACE"`
#' @param log_file A character string specifying the path to the log file. 
#'   Ignored if `store_log = FALSE`. Defaults to `"app_log.txt"`.
#' @param json A logical value indicating whether to save logs in JSON format.
#'   Defaults to `FALSE`. When `TRUE`, logs are written to `log_file` as JSON objects.
#' @param store_log A logical value indicating whether logs should be saved 
#'   to a file. Defaults to `FALSE`. If `TRUE`, logs are printed to the console
#'   and stored in `log_file`.
#'
#' @details
#' - **Console Logging**: All messages are always logged to the console.
#' - **File Logging**: If `store_log = TRUE` and `log_file` is specified, 
#'   messages are logged to the file in either plain text or JSON format.
#' - **JSON Logs**: When `json = TRUE`, log messages are stored as structured
#'   JSON objects with the fields:
#'   - `timestamp`: The time the message was logged.
#'   - `level`: The severity level of the log.
#'   - `message`: The actual log message.
#'
#' @return
#' The function is called for its side effects of logging messages and does
#' not return a value.
#'
#' @examples
#' # Log a simple informational message to the console
#' logr_msg("Application started.")
#'
#' # Log an error message to the console and a file
#' logr_msg("Failed to connect to database.", level = "ERROR", log_file = "error_log.txt")
#'
#' # Log a success message in JSON format
#' logr_msg("User login successful.", level = "SUCCESS", log_file = "app_log.json", json = TRUE)
#'
#' # Log a warning message to the console only (no file storage)
#' logr_msg("Low memory warning.", level = "WARN", store_log = FALSE)
#'
#' @seealso
#' - [logger::log_appender()] for configuring log destinations.
#' - [logger::log_formatter()] for customizing log message formats.
#' - [jsonlite::toJSON()] for converting R objects to JSON.
#'
#' @export
#' 
logr_msg <- function(message, level = "INFO", log_file = "app_log.txt", json = FALSE, store_log = FALSE) {
  
  # Console logging 
  logger::log_formatter(formatter = logger::formatter_glue)
  logger::log_layout(layout = logger::layout_glue_generator())
  
  # configure file logging 
  if (store_log) {
    log_dir <- dirname(log_file)
    if (!dir.exists(log_dir)) {
      dir.create(log_dir, recursive = TRUE)
    }
    if (!file.exists(log_file)) {
      file.create(log_file)
    }
    
    if (json) {
      logger::log_appender(appender = logger::appender_tee(log_file))
      logger::log_layout(layout = logger::layout_json())
    } else {
      logger::log_appender(appender = logger::appender_tee(log_file))
      logger::log_layout(layout = logger::layout_glue_generator())
    }
  } else {
    # prevent file logging
    logger::log_appender(appender = logger::appender_console)
  }
  
  # levels
  switch(
    level,
    "FATAL" = logger::log_fatal("{message}"),
    "ERROR" = logger::log_error("{message}"),
    "WARN" = logger::log_warn("{message}"),
    "SUCCESS" = logger::log_success("{message}"),
    "INFO" = logger::log_info("{message}"),
    "DEBUG" = logger::log_debug("{message}"),
    "TRACE" = logger::log_trace("{message}"),
    logger::log_info("{message}") # default to INFO if level is invalid
  )
}
