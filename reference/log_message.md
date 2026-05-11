# Log Application Behaviors

A simple logging function for logging Shiny events and behaviors.

## Usage

``` r
log_message(message, log_file = "logs/app_log.txt", save = FALSE)
```

## Arguments

- message:

  log message

- log_file:

  name of log file (defaults to "app_log.txt")

- save:

  print or save log file

## Value

A log message to the console and the `log_file`.

## See also

Other **Utility Functions**:
[`scatter_plot()`](https://mjfrigaard.github.io/sap/reference/scatter_plot.md)

## Examples

``` r
if (interactive()) {
  log_message("message")
}
```
