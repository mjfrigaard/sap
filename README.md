<h1 align="center"> <code>moviesApp</code> </h1>
<h3 align="center"> A Shiny App-Package </h3>
<h5 align="center"> Code examples for <a href="https://mjfrigaard.github.io/shinyap/"> Shiny App-Packages </a> </h5>

<hr>

# moviesApp

`moviesApp` provides the code examples in for the [Shiny App-Packages](https://mjfrigaard.github.io/shinyap/) book and the [Developing & Testing Your Shiny Application](https://mjfrigaard.github.io/dev-test-shiny/) workshop provided at R in Pharma (2023).

**Movie review data application**

The original code and data for the Shiny app comes from the [Building Web Applications with Shiny](https://rstudio-education.github.io/shiny-course/) course.

## Using code examples

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
git checkout <branch_name>
```

------------------------------------------------------------------------

# Branches

View the various versions of application in the [`moviesApp` branches](https://github.com/mjfrigaard/moviesApp/branches/all).

## Special topic: Debugging 

The `21.2_debug-selected_vars` branch is the second step of 5 on debugging. This branch should also be loaded, documented, installed before the application is launched.

```r
devtools::load_all()
```

```
ℹ Loading moviesApp
```

```r
devtools::document()
```

```
ℹ Updating moviesApp documentation
ℹ Loading moviesApp
Documentation completed
```

```r
devtools::install()
```

```
==> R CMD INSTALL --preclean --no-multiarch --with-keep.source moviesApp

* installing to library ‘/Library/Frameworks/R.framework/Versions/4.3-x86_64/Resources/library’
* installing *source* package ‘moviesApp’ ...
** using staged installation
** R
** data
*** moving datasets to lazyload DB
** inst
** byte-compile and prepare package for lazy loading
** help
*** installing help indices
** building package indices
** testing if installed package can be loaded from temporary location
** testing if installed package can be loaded from final location
** testing if installed package keeps a record of temporary installation path
* DONE (moviesApp)
```

```
Restarting R session...
```

```r
library(moviesApp)
movies_app(run = 'p')
```

### Structure 


<details>

```
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

17 directories, 48 files
```

</details>


