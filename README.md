24 March, 2025 14:58:57

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

You are reading the doc about version : 0.0.0.9230

This README has been compiled on the

``` r
Sys.time()
#> [1] "2025-03-24 14:58:58 MST"
```

Here are the tests results and package coverage:

``` r
devtools::check(quiet = TRUE)
#> ℹ Loading gap
#> ── R CMD check results ───────────────────────────────────── gap 0.0.0.9230 ────
#> Duration: 44s
#> 
#> ❯ checking Rd \usage sections ... WARNING
#>   Undocumented arguments in Rd file 'scatter_plot.Rd'
#>     ‘df’ ‘x_var’ ‘y_var’ ‘col_var’ ‘alpha_var’ ‘size_var’
#>   
#>   Functions with \usage entries need to have the appropriate \alias
#>   entries, and all their arguments documented.
#>   The \usage entries must correspond to syntactically valid R code.
#>   See chapter ‘Writing R documentation files’ in the ‘Writing R
#>   Extensions’ manual.
#> 
#> ❯ checking package dependencies ... NOTE
#>   Package suggested but not available for checking: ‘spelling’
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
#> 0 errors ✔ | 1 warning ✖ | 5 notes ✖
#> Error: R CMD check found WARNINGs
```

``` r
covr::package_coverage()
#> Error in loadNamespace(x): there is no package called 'covr'
```
