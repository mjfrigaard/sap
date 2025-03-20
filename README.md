20 March, 2025 14:23:42

<!-- README.md is generated from README.Rmd. Please edit that file -->

# `{gap}`: a golem app package

<!-- badges: start -->

[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://lifecycle.r-lib.org/articles/stages.html#experimental)
[![Codecov test
coverage](https://codecov.io/gh/mjfrigaard/sap/graph/badge.svg)](https://app.codecov.io/gh/mjfrigaard/sap)
[![Coveralls test
coverage](https://coveralls.io/repos/github/mjfrigaard/sap/badge.svg)](https://coveralls.io/r/mjfrigaard/sap?branch=02.1_shiny-app)
<!-- badges: end -->

## Installation

You can install the development version of `{gap}` like so:

``` r
remotes::install_github(repo = "mjfrigaard/sap", ref = "23_golem")
```

## Run

You can launch the application by running:

``` r
gap::run_app()
```

## About

You are reading the doc about version : 0.0.0.9000

This README has been compiled on the

``` r
Sys.time()
#> [1] "2025-03-20 14:23:42 MST"
```

Here are the tests results and package coverage:

``` r
devtools::check(quiet = TRUE)
#> ℹ Loading gap
#> ── R CMD check results ───────────────────────────────────── gap 0.0.0.9000 ────
#> Duration: 42.5s
#> 
#> ❯ checking for future file timestamps ... NOTE
#>   unable to verify current time
#> 
#> ❯ checking top-level files ... NOTE
#>   Non-standard file/directory found at top level:
#>     ‘app.R’
#> 
#> ❯ checking package subdirectories ... NOTE
#>   Problems with news in ‘NEWS.md’:
#>   No news entries found.
#> 
#> ❯ checking R code for possible problems ... NOTE
#>   mod_scatter_display_server : <anonymous>: no visible binding for global
#>     variable ‘movies’
#>   Undefined global functions or variables:
#>     movies
#> 
#> 0 errors ✔ | 0 warnings ✔ | 4 notes ✖
```

``` r
covr::package_coverage()
#> gap Coverage: 85.27%
#> R/run_app.R: 0.00%
#> R/utils_tests.R: 53.85%
#> R/mod_scatter_display.R: 56.76%
#> R/golem_utils_server.R: 77.78%
#> R/golem_utils_ui.R: 87.94%
#> R/app_config.R: 100.00%
#> R/app_server.R: 100.00%
#> R/app_ui.R: 100.00%
#> R/mod_aes_inputs.R: 100.00%
#> R/mod_var_inputs.R: 100.00%
#> R/utils_scatter_display.R: 100.00%
```
