<h1 align="center"> <code>sap</code> </h1>
<h3 align="center"> A Shiny App-Package </h3>
<h5 align="center"> Code examples for <a href="https://mjfrigaard.github.io/shiny-app-pkgs/"> Shiny App-Packages </a> </h5>

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


## `08_launch`

The [`08_launch`](https://github.com/mjfrigaard/sap/tree/08_launch) branch of `sap` covers launching your app-package from a standalone app function and `app.R` file. 

### display_type()

```r
display_type <- function(run = "w") {
  if (interactive()) {
    if (Sys.getenv("RSTUDIO") == "1") {
      
      switch(
        run,
        p = options(shiny.launch.browser = .rs.invokeShinyPaneViewer),
        b = options(shiny.launch.browser = .rs.invokeShinyWindowExternal),
        w = options(shiny.launch.browser = .rs.invokeShinyWindowViewer),
        NULL = options(shiny.launch.browser = NULL)
      )
      environment <- "RStudio"
      shinyViewerType <- getOption('shiny.launch.browser') |>
        attributes() |>
        unlist() |>
        unname()
      
      cli::cli_alert_info("App running in {environment}")
      cli::cli_alert_info("shinyViewerType set to {shinyViewerType}")
    } else {
      environment <- "RStudio"
      cli::cli_alert_info("App not running in {environment}")
    }
  } else {
    cli::cli_alert_info("App not running in interactive session")
  }
}
```

### Updated launch_app()

```r
launch_app <- function(options = list(), run = "p") {
  display_type(run = run)
  shinyApp( 
    ui = movies_ui(),
    server = movies_server,
    options = options
  )
}
```


### app.R

```r
withr::with_options(new = list(shiny.autoload.r = FALSE), code = {
  if (!interactive()) {
    sink(stderr(), type = "output")
    tryCatch(
      expr = {
        library(sap)
      },
      error = function(e) {
        pkgload::load_all()
      }
    )
  } else {
    pkgload::load_all()
  }
    sap::launch_app(
      options = list(test.mode = TRUE), run = 'p')
}) 
```




