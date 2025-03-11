
<!-- README.md is generated from README.Rmd. Please edit that file -->

# Shiny App-Packages (`sap`)

Shiny App-Packages, or `sap`, provides the code examples in for the [Shiny App-Packages](https://mjfrigaard.github.io/shiny-app-pkgs/) book and the [Developing & Testing Your Shiny Application](https://mjfrigaard.github.io/dev-test-shiny/) workshop provided at R in Pharma (2023).

Install `sap` using `remotes`:

``` r
install.packages('remotes')
remotes::install_github('mjfrigaard/sap', ref = '23_llm-shiny-assist')
```

## `23_llm-shiny-assist`

[`23_llm-shiny-assist`](https://github.com/mjfrigaard/sap/tree/23_llm-shiny-assist) demonstrates and application created in 5 prompts with [Shiny Assistant](https://gallery.shinyapps.io/assistant/).

Launch the application using;

``` r
library(sap)
launch_app(app = "assist")
```

View the contents of this application in `inst/shiny-assist/movies`:

```sh
inst/shiny-assist/
└── movies
    ├── R
    │   ├── about_module.R
    │   ├── app_server.R
    │   ├── app_ui.R
    │   ├── controls_module.R
    │   ├── movie_visualization_app.R
    │   └── plot_module.R
    └── app.R

3 directories, 7 files
```

### Movie review data application

The original code and data for the Shiny app comes from the [Building Web Applications with Shiny](https://rstudio-education.github.io/shiny-course/) course.

