#' Log Messages to Console and File with Optional JSON Format
#'
#' A utility function for logging messages to the console and optionally to a
#' log file. Messages can be stored as plain text (default) or in JSON 
#' format, providing flexibility for human-readable or structured log storage.
#' This function uses the `logger` package for console and plain text logging
#' and integrates JSON logging using the `jsonlite` package.
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
#' @param log_file A character string specifying the path to the log file. If
#' `NULL`, logs are not saved to a file, and only console logging is performed. 
#' Defaults to `NULL`.
#' @param json A logical value indicating whether to save logs in JSON format.
#' Defaults to `FALSE`. When `TRUE`, logs are written to the specified 
#' `log_file` as JSON objects.
#'
#' @details
#' - **Console Logging**: All messages are always logged to the console.
#' - **File Logging**: If `log_file` is specified, messages are logged to the
#' file in either plain text 
#'   or JSON format, depending on the value of `json`.
#' - **JSON Logs**: When `json = TRUE`, log messages are stored as structured
#' JSON objects with the fields:
#'   - `timestamp`: The time the message was logged.
#'   - `level`: The severity level of the log.
#'   - `message`: The actual log message.
#'
#' @return
#' The function is called for its side effects of logging messages and does
#' not return a value.
#'
#' @examples
#' # log a simple informational message to the console
#' logr_msg("Application started.")
#'
#' # log an error message to the console and a file in plain text format
#' logr_msg(message = "Failed to connect to the database.", 
#'           level = "ERROR", 
#'           log_file = "error_log.txt")
#'
#' # log a success message in JSON format
#' logr_msg(message = "User login successful.", 
#'          level = "SUCCESS", 
#'          log_file = "app_log.json", 
#'          json = TRUE)
#'
#' # log a warning message to the console only
#' logr_msg(message = "Low memory warning.", 
#'          level = "WARN")
#'
#' @seealso
#' - [logger::log_appender()] for configuring log destinations.
#' - [logger::log_formatter()] for customizing log message formats.
#' - [jsonlite::toJSON()] for converting R objects to JSON.
#'
#' @export
#' 
logr_msg <- function(message, level = "INFO", log_file = NULL, json = FALSE) {

  # Set default formatter
  logger::log_formatter(formatter = logger::formatter_glue)

  # Log to console by default
  switch(
    level,
    "FATAL"   = logger::log_fatal("{message}"),
    "ERROR"   = logger::log_error("{message}"),
    "WARN"    = logger::log_warn("{message}"),
    "SUCCESS" = logger::log_success("{message}"),
    "DEBUG"   = logger::log_debug("{message}"),
    "TRACE"   = logger::log_trace("{message}"),
    logger::log_info("{message}")  # Default fallback
  )

  # Log to file only if log_file is specified
  if (!is.null(log_file)) {
    log_dir <- dirname(log_file)

    if (!dir.exists(log_dir)) {
      dir.create(log_dir, recursive = TRUE)
    }

    if (!file.exists(log_file)) {
      file.create(log_file)
    }

    if (json) {
      logger::log_appender(logger::appender_tee(log_file))
      logger::log_layout(logger::layout_json())
    } else {
      logger::log_appender(logger::appender_tee(log_file))
      logger::log_layout(logger::layout_glue_generator())
    }
  }
}
