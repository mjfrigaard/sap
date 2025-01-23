#' Log Application Behaviors
#'
#' A simple logging function for logging Shiny events and behaviors.
#' 
#' @param message log message
#' @param log_file name of log file (defaults to "app_log.txt")
#' @param save print or save log file
#'
#' @return A log message to the console and the `log_file`.
#'
#' @family **Utility Functions**
#' 
#'
#' @examples
#' if (interactive()) {
#'   log_message("message")
#' }
#' 
#' @export
log_message <- function(message, log_file = "logs/app_log.txt", save = FALSE) {
  log_dir <- dirname(log_file)
  if (!dir.exists(log_dir)) {
    dir.create(log_dir, recursive = TRUE)
  }
  timestamp <- format(Sys.time(), "%Y-%m-%d %H:%M:%S")
  # log entry
  log_entry <- sprintf("[%s] %s", timestamp, message)
  # save 
  if (save) {
    tryCatch(
      {
        cat(log_entry, "\n", file = log_file, append = TRUE)
      },
      error = function(e) {
        warning(sprintf("Failed to write to log file '%s': %s", log_file, e$message))
      }
    )
  }
  # print
  message(log_entry)
}