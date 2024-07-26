<h1 align="center"> <code>shinyAppPkgs</code> </h1>
<h3 align="center"> A Shiny App-Package </h3>
<h5 align="center"> Code examples for <a href="https://mjfrigaard.github.io/shinyap/"> Shiny App-Packages </a> </h5>

<hr>

# shinyAppPkgs

`shinyAppPkgs` provides the code examples in for the [Shiny App-Packages](https://mjfrigaard.github.io/shiny-app-pkgs/) book and the [Developing & Testing Your Shiny Application](https://mjfrigaard.github.io/dev-test-shiny/) workshop provided at R in Pharma (2023).

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
git clone https://github.com/mjfrigaard/shinyAppPkgs.git
cd shinyAppPkgs
git checkout <branch_name>
open shinyAppPkgs.Rproj
```

------------------------------------------------------------------------

# Branches

View all the applications in the [`shinyAppPkgs` branches](https://github.com/mjfrigaard/shinyAppPkgs/branches/all).

## Tests 

### `12.3_tests-snapshots`

[`12.3_tests-snapshots`](https://github.com/mjfrigaard/shinyAppPkgs/tree/12.3_tests-snapshots) explores using test snapshots with unit tests.

```
tests
├── testthat
│   ├── _snaps
│   │   └── text_logo.md
│   ├── fixtures
│   │   ├── make-tidy_ggp2_movies.R
│   │   └── tidy_ggp2_movies.rds
│   ├── helper.R
│   ├── test-scatter_plot.R
│   └── test-text_logo.R
└── testthat.R

4 directories, 7 files
```
