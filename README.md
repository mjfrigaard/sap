<h1 align="center"> <code>moviesApp</code> </h1>
<h3 align="center"> A Shiny App-Package </h3>
<h5 align="center"> Code examples for <a href="https://mjfrigaard.github.io/shinyap/"> Shiny App-Packages </a> </h5>

<hr>

# moviesApp

`moviesApp` provides the code examples in for the [Shiny App-Packages](https://mjfrigaard.github.io/shinyap/) book and the [Developing & Testing Your Shiny Application](https://mjfrigaard.github.io/dev-test-shiny/) workshop provided at R in Pharma (2023).

**Movie review data application**

The original code and data for the Shiny app comes from the [Building Web Applications with Shiny](https://rstudio-education.github.io/shiny-course/) course.

## Using code examples

The branches in this repo contain a Shiny application in the various stages of development. If you're following along in the <a href="https://mjfrigaard.github.io/dev-test-shiny/slides/wrkshp.html#/title-slide">workshop slides</a>, the branch name is in the slide footer:

<div>
<p align="center"> 
  <img src="https://mjfrigaard.github.io/dev-test-shiny/img/slide_03_proj-app.png" alt="Workshop slide" width="80%">
</p>
</div>

<p align="left">
  If you're following along in the <a href="https://mjfrigaard.github.io/shinyap/">Shiny App-Packages</a> book, look for the Git Branch icon in the margin:
  </p>

<div>

<p align="right"> 
  <img src="https://raw.githubusercontent.com/mjfrigaard/shinyap/main/images/new_branch_ico.png" alt="Git branch icon" width="33%">

</div>

<p align="left">
You can change the branch in the Posit Workbench IDE's <strong>Git</strong> pane.
</p>



<div>
<p align="center"> 
  <img src="https://mjfrigaard.github.io/dev-test-shiny/img/cloud_branches.gif" alt="Animated git branches" width="100%">
</p>

</div>

Or use the terminal

``` bash
git checkout <branch_name>
```

------------------------------------------------------------------------

# Branches

View the various versions of application in the [`moviesApp` branches](https://github.com/mjfrigaard/moviesApp/branches/all).

# `fw_gap`

<!-- badges: start -->

[![Codecov test
coverage](https://codecov.io/gh/mjfrigaard/gap/branch/main/graph/badge.svg)](https://app.codecov.io/gh/mjfrigaard/gap?branch=main)

<!-- badges: end -->

The goal of `gap` is to demonstrate the `golem` framework.

## Installation

You can install the development version of `gap` from
[GitHub](https://github.com/) with:

``` r
install.packages("devtools")
devtools::install_github("mjfrigaard/moviesApp")
```

Checkout the `gap` branch

```bash
git checkout fw_gap
```

Load, document, and install the package:

```r
devtools::load_all()

devtools::document()

devtools::install()
```

## Run

You can run the application with the following:

``` r
library(gap)
gap::run_app()
```

## Code of Conduct

Please note that the `gap` project is released with a [Contributor Code
of
Conduct](https://contributor-covenant.org/version/2/1/CODE_OF_CONDUCT.html).
By contributing to this project, you agree to abide by its terms.
