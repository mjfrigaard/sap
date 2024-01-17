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

## Tests 

### `14_tests-system`

[`14_tests-system`](https://github.com/mjfrigaard/moviesApp/tree/14_tests-system) gives examples of [`shinytest2` tests.](https://rstudio.github.io/shinytest2/articles/shinytest2.html)

```
tests
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

7 directories, 20 files
```
