# Shiny App-Packages

Shiny App-Packages (or `sap`) provides the code examples in for the
[Shiny App-Packages](https://mjfrigaard.github.io/shiny-app-pkgs/) book.
You can install the `pkgdown` branch of the `sap` package using
`remotes`:

``` r

install.packages('remotes')
remotes::install_github('mjfrigaard/sap', ref = '22_pkgdown')
```

The [`22_pkgdown`](https://github.com/mjfrigaard/sap/tree/22_pkgdown)
branch demonstrates how to create a package website using `pkgdown` and
GitHub Actions.

## Movie review data application

The original code and data for the Shiny app comes from the [Building
Web Applications with
Shiny](https://rstudio-education.github.io/shiny-course/) course.

Launch the application using;

``` r

library(sap)
launch_app()
```

## Learn more

The [Developing & Testing Your Shiny
Application](https://mjfrigaard.github.io/dev-test-shiny/) workshop was
provided at R in Pharma (2023).
