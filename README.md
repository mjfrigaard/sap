<h1 align="center"> <code>sap</code> </h1>
<h3 align="center"> A Shiny App-Package </h3>
<h5 align="center"> Code examples for <a href="https://mjfrigaard.github.io/shiny-app-pkgs/"> Shiny App-Packages </a> </h5>

<hr>

# sap

`sap` provides the code examples in for the [Shiny App-Packages](https://mjfrigaard.github.io/shiny-app-pkgs/) book and the [Developing & Testing Your Shiny Application](https://mjfrigaard.github.io/dev-test-shiny/) workshop provided at R in Pharma (2023).

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
git clone https://github.com/mjfrigaard/sap.git
cd sap
git checkout <branch_name>
open sap.Rproj
```

------------------------------------------------------------------------

# Branches

View all the applications in the [`sap` branches](https://github.com/mjfrigaard/sap/branches/all).


## `09_inst`

The [`09_inst`](https://github.com/mjfrigaard/sap/tree/09_inst) branch of `sap` covers handling external resources for you application. 

### `inst/` folder

This branch contains the following `inst/` folder files:

```sh
inst
├── extdata
│   └── movies.fst
├── quarto
│   ├── _quarto.yml
│   ├── index.html
│   ├── index.qmd
│   └── www
│       ├── quarto.png
│       └── styles.scss
├── tidy-movies
│   ├── R
│   │   ├── devServer.R
│   │   ├── devUI.R
│   │   ├── dev_mod_scatter.R
│   │   └── dev_mod_vars.R
│   ├── app.R
│   ├── imdb.png
│   └── tidy_movies.fst
└── www
    ├── bootstrap.png
    └── shiny.png
```

Three app variations are in this branch, and they can all be launched using the `launch_app()` function.

### launch_app(app = "movies")

This launches our standard `movies` data application with the Shiny logo. 

### launch_app(app = "bslib")

This launches a slight variation of the `movies` data application, but with a dark theme and the Bootstrap logo. 

### launch_app(app = "ggp2")

Launches an application with a tidy version of the [`ggplot2movies` data](https://github.com/hadley/ggplot2movies) in [`fst` format](https://www.fstpackage.org/). 

### launch_app(app = "quarto")

Launches a `movies` data application stored in a [Quarto document](https://quarto.org/docs/interactive/shiny/). 

### app.R

The updated `app.R` file will launch a production version of the application: 

```r
withr::with_options(new = list(shiny.autoload.r = FALSE), code = {
  if (!interactive()) {
    sink(stderr(), type = "output")
    tryCatch(
      expr = {
        library(sap)
      },
      error = function(e) {
        pkgload::load_all()
      }
    )
    shinyAppDir(appDir = system.file("prod/app", package = "sap"))
  } else {
    pkgload::load_all()
  }
  launch_app(options = list(test.mode = FALSE), run = 'p')
})
```

Deploy with: 

```r
library(sap)
rsconnect::deployApp(appName = 'movie-reviews-prod')
```





