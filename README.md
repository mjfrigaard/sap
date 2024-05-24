
<!-- README.md is generated from README.Rmd. Please edit that file -->

# moviesApp

<!-- badges: start -->
<!-- badges: end -->

`moviesApp` provides an example of deploying an app-package website with
[`pkgdown`](https://pkgdown.r-lib.org/).

## Install

Install the development version of `moviesApp` using
[`pak`](https://pak.r-lib.org/):

``` r
install.packages('pak')
pak::pak("mjfrigaard/moviesApp")
```

## Launch

``` r
library(moviesApp)
movies_app()
```

### `pkgdown` setup

Install `pkgdown`:

``` r
pak::pak('pkgdown')
```

Set up GitHub Actions:

``` r
 usethis::use_pkgdown_github_pages()
```

Change the branches for the triggering event in
`.github/workflows/pkgdown.yml` to only trigger on the [`17_pkgdown`
branch](https://github.com/mjfrigaard/moviesApp/tree/17_pkgdown):

``` yml
on:
  push:
    branches: [17_pkgdown]
  pull_request:
    branches: [17_pkgdown]
```

Build site:

``` r
pkgdown::build_site_github_pages()
```

Add, commit, and push:

``` bash
git add .
git commit -m "updates to _pkgdown.yml"
git push
```

### Movie review data application

`moviesApp` provides the code examples in for the [Shiny
App-Packages](https://mjfrigaard.github.io/shinyap/) book and the
[Developing & Testing Your Shiny
Application](https://mjfrigaard.github.io/dev-test-shiny/) workshop
provided at R in Pharma (2023). The original code and data for the Shiny
app comes from the [Building Web Applications with
Shiny](https://rstudio-education.github.io/shiny-course/) course.
