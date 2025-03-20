
<!-- README.md is generated from README.Rmd. Please edit that file -->

# `{gap}`

<!-- badges: start -->

<!-- badges: end -->

## Installation

You can install the development version of `{gap}` like so:

``` r
# FILL THIS IN! HOW CAN PEOPLE INSTALL YOUR DEV PACKAGE?
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
#> [1] "2025-03-18 22:19:40 MST"
```

Here are the tests results and package coverage:

``` r
devtools::check(quiet = TRUE)
#> ℹ Loading gap
#> ── R CMD check results ───────────────────────────────────── gap 0.0.0.9000 ────
#> Duration: 4s
#> 
#> ❯ checking package dependencies ... ERROR
#>   Namespace dependency missing from DESCRIPTION Imports/Depends entries: ‘rlang’
#>   
#>   See section ‘The DESCRIPTION file’ in the ‘Writing R Extensions’
#>   manual.
#> 
#> 1 error ✖ | 0 warnings ✔ | 0 notes ✔
#> Error: R CMD check found ERRORs
```

``` r
covr::package_coverage()
#> gap Coverage: 0.00%
#> R/app_config.R: 0.00%
#> R/app_server.R: 0.00%
#> R/app_ui.R: 0.00%
#> R/mod_aes_inputs.R: 0.00%
#> R/mod_scatter_display.R: 0.00%
#> R/mod_var_inputs.R: 0.00%
#> R/run_app.R: 0.00%
#> R/utils_scatter.R: 0.00%
```
