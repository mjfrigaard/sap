# Log test messages (helper)

`test_logger()` logs informational messages using the `cli` package. It
allows optional `start` and `end` tags to indicate the beginning and end
of a process.

## Usage

``` r
test_logger(start = NULL, end = NULL, msg)
```

## Arguments

- start:

  A character string indicating the start tag. Default is `NULL`.

- end:

  A character string indicating the end tag. Default is `NULL`.

- msg:

  A character string containing the log message.

## Value

Logs messages and returns `NULL` (used for side effects).

## Details

- If both `start` and `end` are `NULL`, logs only the message.

- If `start` is provided and `end` is `NULL`, logs a message prefixed
  with `START <start> = <msg>`.

- If `start` is `NULL` and `end` is provided, logs a message prefixed
  with `END <end> = <msg>`.

- If both `start` and `end` are provided, logs both `START` and `END`
  messages.

## Examples

``` r
test_logger(msg = "Processing started")
#> 
#> TEST:[2026-05-11 18:32:17] = Processing started
test_logger(start = "Step1", msg = "Loading data")
#> 
#> TEST: START [2026-05-11 18:32:17] Step1 = Loading data
test_logger(end = "Step1", msg = "Data loaded successfully")
#> 
#> TEST: END [2026-05-11 18:32:17] Step1 = Data loaded successfully
test_logger(start = "Step2", end = "Step2", msg = "Performing computation")
#> 
#> TEST: START [2026-05-11 18:32:17]Step2 = Performing computation
#> 
#> TEST: END [2026-05-11 18:32:17] Step2 = Performing computation
```
