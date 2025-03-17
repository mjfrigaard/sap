
<!-- README.md is generated from README.Rmd. Please edit that file -->

# Shiny App-Packages (`sap`)

Shiny App-Packages, or `sap`, provides the code examples in for the [Shiny App-Packages](https://mjfrigaard.github.io/shiny-app-pkgs/) book and the [Developing & Testing Your Shiny Application](https://mjfrigaard.github.io/dev-test-shiny/) workshop provided at R in Pharma (2023).

Install `sap` using `remotes`:

``` r
install.packages('remotes')
remotes::install_github('mjfrigaard/sap', ref = '25_llm-chores')
```

## `25_llm-chores`

The [`25_llm-chores`](https://github.com/mjfrigaard/sap/tree/25_llm-chores) branch covers the [`chores` package](https://simonpcouch.github.io/chores/) in Shiny App-Package development. 

Launch the application using;

``` r
library(sap)
launch_app(app = "db")
```

### Movie review data application

The original code and data for the Shiny app comes from the [Building Web Applications with Shiny](https://rstudio-education.github.io/shiny-course/) course.

