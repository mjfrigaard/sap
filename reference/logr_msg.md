# Log Messages to Console and File with Optional JSON Format

A utility function for logging messages to the console and optionally to
a log file. Messages can be stored as plain text (default) or in JSON
format. Additionally, logging to a file can be disabled altogether.

## Usage

``` r
logr_msg(
  message,
  level = "INFO",
  log_file = "app_log.txt",
  json = FALSE,
  store_log = FALSE
)
```

## Arguments

- message:

  A character string representing the message to be logged.

- level:

  A character string indicating the log level. One of:

  - `"FATAL"`

  - `"ERROR"`

  - `"WARN"`

  - `"SUCCESS"`

  - `"INFO"` (default)

  - `"DEBUG"`

  - `"TRACE"`

- log_file:

  A character string specifying the path to the log file. Ignored if
  `store_log = FALSE`. Defaults to `"app_log.txt"`.

- json:

  A logical value indicating whether to save logs in JSON format.
  Defaults to `FALSE`. When `TRUE`, logs are written to `log_file` as
  JSON objects.

- store_log:

  A logical value indicating whether logs should be saved to a file.
  Defaults to `TRUE`:

  - If `TRUE`, logs are printed to the console and stored in `log_file`

  - If `FALSE`, logs are printed to the console

## Value

The function is called for its side effects of logging messages and does
not return a value.

## Details

- **Console Logging**: All messages are always logged to the console.

- **File Logging**: If `store_log = TRUE` and `log_file` is specified,
  messages are logged to the file in either plain text or JSON format.

- **JSON Logs**: When `json = TRUE`, log messages are stored as
  structured JSON objects with the fields:

  - `timestamp`: The time the message was logged.

  - `level`: The severity level of the log.

  - `message`: The actual log message.

## See also

- [`logger::log_appender()`](https://daroczig.github.io/logger/reference/log_appender.html)
  for configuring log destinations.

- [`logger::log_formatter()`](https://daroczig.github.io/logger/reference/log_formatter.html)
  for customizing log message formats.

- [`jsonlite::toJSON()`](https://jeroen.r-universe.dev/jsonlite/reference/fromJSON.html)
  for converting R objects to JSON.

## Examples

``` r
# Log a simple informational message to the console
logr_msg("Application started.")

# Log an error message to the console and a file
logr_msg("Failed to connect to database.", level = "ERROR", log_file = "error_log.txt")

# Log a success message in JSON format
logr_msg("User login successful.", level = "SUCCESS", log_file = "app_log.json", json = TRUE)

# Log a warning message to the console only (no file storage)
logr_msg("Low memory warning.", level = "WARN", store_log = FALSE)
```
