<h1 align="center"> <code>moviesApp</code> </h1>
<h3 align="center"> A Shiny App-Package </h3>
<h5 align="center"> Code examples for <a href="https://mjfrigaard.github.io/shinyap/"> Shiny App-Packages </a> </h5>

<hr>

# moviesApp

`moviesApp` provides the code examples in for the [Shiny App-Packages](https://mjfrigaard.github.io/shinyap/) book and the [Developing & Testing Your Shiny Application](https://mjfrigaard.github.io/dev-test-shiny/) workshop provided at R in Pharma (2023).

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
git clone https://github.com/mjfrigaard/moviesApp.git
cd moviesApp
git checkout <branch_name>
open moviesApp.Rproj
```

------------------------------------------------------------------------

# Branches

View all the applications in the [`moviesApp` branches](https://github.com/mjfrigaard/moviesApp/branches/all).

### Debugging

The [`23.1_debugging`](https://github.com/mjfrigaard/moviesApp/tree/23.1_debugging) branch is the first step of 4 that demonstrate debugging an error in `movies_app()`. 

This branch should be loaded, documented, and installed, then the application should be launched: 

```r
library(moviesApp)
movies_app(run = 'p')
```

Error in the app: 

```
Error: [object Object]
```

Error in the Console: 

```
Warning: Error in ggplot2::geom_point: Problem while computing aesthetics.
ℹ Error occurred in the 1st layer.
Caused by error in `.data[[NULL]]`:
! Must subset the data pronoun with a string, not `NULL`.
```

### Structure 

<details> 

```
.
├── DESCRIPTION
├── NAMESPACE
├── R
│   ├── data.R
│   ├── display_type.R
│   ├── ggp2_movies_app.R
│   ├── mod_scatter_display.R
│   ├── mod_var_input.R
│   ├── movies_app.R
│   ├── movies_server.R
│   ├── movies_ui.R
│   ├── scatter_plot.R
│   └── test_logger.R
├── README.md
├── app
│   └── static
├── app.R
├── data
│   ├── movies.RData
│   └── movies.rda
├── data-raw
│   └── tidy_movies.R
├── inst
│   ├── dev
│   │   ├── app.R
│   │   ├── imdb.png
│   │   └── tidy_movies.fst
│   ├── extdata
│   │   └── movies.fst
│   ├── prod
│   │   └── app
│   │       └── app.R
│   └── www
│       ├── bootstrap.png
│       └── shiny.png
├── man
│   ├── display_type.Rd
│   ├── ggp2_movies_app.Rd
│   ├── mod_scatter_display_server.Rd
│   ├── mod_scatter_display_ui.Rd
│   ├── mod_var_input_server.Rd
│   ├── mod_var_input_ui.Rd
│   ├── movies.Rd
│   ├── movies_app.Rd
│   ├── movies_server.Rd
│   ├── movies_ui.Rd
│   ├── scatter_plot.Rd
│   └── test_logger.Rd
├── moviesApp.Rproj
└── tests
    ├── testthat
    │   ├── _snaps
    │   │   ├── app-feature-01
    │   │   │   ├── feature-01-senario-a-001.json
    │   │   │   ├── feature-01-senario-a-001_.png
    │   │   │   ├── feature-01-senario-b-001.json
    │   │   │   └── feature-01-senario-b-001_.png
    │   │   ├── ggp2_app-feature-01
    │   │   │   ├── ggp2movies_app-feature-01-001.json
    │   │   │   ├── ggp2movies_app-feature-01-001_.new.png
    │   │   │   └── ggp2movies_app-feature-01-001_.png
    │   │   └── shinytest2
    │   │       ├── feature-01-001.json
    │   │       └── feature-01-001_.png
    │   ├── fixtures
    │   │   ├── make-tidy_ggp2_movies.R
    │   │   └── tidy_ggp2_movies.rds
    │   ├── helper.R
    │   ├── setup-shinytest2.R
    │   ├── test-app-feature-01.R
    │   ├── test-ggp2_app-feature-01.R
    │   ├── test-mod_scatter_display.R
    │   ├── test-mod_var_input.R
    │   ├── test-scatter_plot.R
    │   └── test-shinytest2.R
    └── testthat.R

20 directories, 57 files
```

</details> 

