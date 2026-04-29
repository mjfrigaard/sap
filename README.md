<h1 align="center">

<code><strong>sap</strong></code>

</h1>

<h3 align="center">

Code examples for <a href="https://mjfrigaard.github.io/shiny-app-pkgs/"> Shiny App-Packages </a>

</h3>

<hr>

<hr>

# sap

The `sap` app-package is from the [`btw` chapter](https://mjfrigaard.github.io/shiny-app-pkgs/btw.html) of the [Shiny App-Packages book](https://mjfrigaard.github.io/shiny-app-pkgs/).

## Shiny LLM Tools: `btw`

The [`btw`](https://posit-dev.github.io/btw/index.html) package expands the use of LLM models to,

> "*A complete toolkit for connecting R and LLMs*"

To get started, install the `ellmer` and `btw` packages below:

``` r
install.packages(c('ellmer', 'btw'))
# or the dev versions
# install.packages("pak")
pak::pak('tidyverse/ellmer')
pak::pak("posit-dev/btw")
```

## Load and Install the Package

Load, document, and install the package:

``` r
devtools::load_all()
```

``` r
devtools::document()
```

``` r
devtools::install(upgrade = FALSE)
```
