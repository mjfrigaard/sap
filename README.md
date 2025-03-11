<h1 align="center"> <code><strong>sap</strong></code> </h1>
<h3 align="center"> Code examples for <a href="https://mjfrigaard.github.io/shiny-app-pkgs/"> Shiny App-Packages </a> </h3>
<hr>

<hr>

# sap

`sap` provides the code examples in for the [Shiny App-Packages](https://mjfrigaard.github.io/shiny-app-pkgs/) book and the [Developing & Testing Your Shiny Application](https://mjfrigaard.github.io/dev-test-shiny/) workshop provided at R in Pharma (2023).

## Movie review data application

The original code and data for the Shiny app comes from the [Building Web Applications with Shiny](https://rstudio-education.github.io/shiny-course/) course.

# Using code examples

The branches in this repo contain a Shiny application in the various stages of development. The best way to access each branch/app is with the [`shinypak` package](https://mjfrigaard.github.io/shinypak/). 

```r
# install.packages("pak")
pak::pak("mjfrigaard/shinypak")
library(shinypak)
```

List all the apps with `list_apps()`


```r
head(list_apps())
#>                  branch        last_updated
#> 2     01_whole-app-game 2024-01-01 14:11:32
#> 1        02.1_shiny-app 2024-01-04 13:05:58
#> 4       02.2_movies-app 2024-01-04 13:07:59
#> 5         02.3_proj-app 2024-01-04 13:08:58
#> 6      03.1_description 2024-01-04 13:10:00
#> 7            03.2_rproj 2024-01-04 13:25:06
```

Launch an app with `launch()`

```r
launch(app = "02.3_proj-app")
```

Or use the terminal

``` bash
git clone https://github.com/mjfrigaard/sap.git
cd sap
git checkout <branch_name>
open sap.Rproj
```

------------------------------------------------------------------------

# Branches

View all the applications in the [`sap` branches](https://github.com/mjfrigaard/sap/branches/all).

## `13_logging`

The [`13_logging`](https://github.com/mjfrigaard/sap/tree/13_logging) branch covers using logging to monitor application performance and behavior. 

## Logging functions

```r
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
```

```r
logr_msg <- function(message, level = "INFO", log_file = "app_log.txt", json = FALSE) {

  # check the log file and directory
  log_dir <- dirname(log_file)
  if (!dir.exists(log_dir)) {
    dir.create(log_dir, recursive = TRUE)
  }
  if (!file.exists(log_file)) {
    file.create(log_file)
  }
  
  # default formatter for all logs
  logger::log_formatter(formatter = logger::formatter_glue)

  # default logging to console and a file
  if (json) {
    # JSON format
    logger::log_appender(appender = logger::appender_tee(log_file))
    logger::log_layout(layout = logger::layout_json())
  } else {
    # plain text format
    logger::log_appender(appender = logger::appender_tee(log_file))
    logger::log_layout(layout = logger::layout_glue_generator())
  }
  
  # log levels
  switch(
    level,
    "FATAL" = logger::log_fatal("{message}"),
    "ERROR" = logger::log_error("{message}"),
    "WARN" = logger::log_warn("{message}"),
    "SUCCESS" = logger::log_success("{message}"),
    "INFO" = logger::log_info("{message}"),
    "DEBUG" = logger::log_debug("{message}"),
    "TRACE" = logger::log_trace("{message}"),
    logger::log_info("{message}") # INFO if level is invalid
  )
}
```

## Start up message 

In the `R/zzz.R` file, we have a start-up message: 

```r
.onAttach <- function(libname, pkgname) {
  
  branch <- if (isTRUE(system("git rev-parse --is-inside-work-tree", intern = TRUE) == "true")) {
    tryCatch({
      system("git rev-parse --abbrev-ref HEAD", intern = TRUE)
    }, error = function(e) "unknown")
  } else {
    "not a Git repository"
  }


  version <- utils::packageVersion(pkgname)


  description <- utils::packageDescription(pkgname)
  imports <- description$Imports
  suggests <- description$Suggests
  depends <- description$Depends


  parse_dependencies <- function(dep_string) {
    if (is.null(dep_string)) return("None")
    deps <- strsplit(dep_string, ",\\s*")[[1]]
    paste(deps, collapse = ", ")
  }

  imports <- parse_dependencies(imports)
  suggests <- parse_dependencies(suggests)
  depends <- parse_dependencies(depends)

  
  cli::cli_inform("{.strong Welcome to the {.pkg {pkgname}} package (version {version}) {cli::symbol$smiley}!}", class = "packageStartupMessage")
  
  cli::cli_inform("{.strong Current branch:}", class = "packageStartupMessage")
  cli::cli_inform("{.emph {cli::symbol$pointer} {branch}}", class = "packageStartupMessage")

  cli::cli_inform("{.strong Dependencies:}", class = "packageStartupMessage")
  cli::cli_inform("{.emph {cli::symbol$pointer} Imports: {imports}}", class = "packageStartupMessage")
  cli::cli_inform("{.emph {cli::symbol$pointer} Suggests: {suggests}}", class = "packageStartupMessage")
  cli::cli_inform("{.emph {cli::symbol$pointer} Depends: {depends}}", class = "packageStartupMessage")

  cli::cli_inform("{.strong Loaded from:}", class = "packageStartupMessage")
  cli::cli_inform("{.emph {cli::symbol$pointer} {libname}}", class = "packageStartupMessage")

}
```