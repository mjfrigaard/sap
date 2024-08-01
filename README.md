<h1 align="center"> <code><strong>shinyrPkgs</strong></code> </h1>
<h3 align="center"> Code examples for <a href="https://mjfrigaard.github.io/shiny-app-pkgs/"> Shiny App-Packages </a> </h3>
<hr>

# shinyrPkgs

`shinyrPkgs` provides the code examples in for the [Shiny App-Packages](https://mjfrigaard.github.io/shiny-app-pkgs/) book and the [Developing & Testing Your Shiny Application](https://mjfrigaard.github.io/dev-test-shiny/) workshop provided at R in Pharma (2023).

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
git clone https://github.com/mjfrigaard/shinyrPkgs.git
cd shinyrPkgs
git checkout <branch_name>
open shinyrPkgs.Rproj
```

------------------------------------------------------------------------

# Branches

View all the applications in the [`shinyrPkgs` branches](https://github.com/mjfrigaard/shinyrPkgs/branches/all).

## Tests 

### `11_tests-specs`

[`11_tests-specs`](https://github.com/mjfrigaard/shinyrPkgs/tree/11_tests-specs) covers working through a set of app specifications and building a traceability matrix. 

`usethis::use_testthat(3)` adds the following to the `DESCRIPTION`:

```
Config/testthat/edition: 3
```

Creating a new test file with `usethis::use_test("scatter_plot")`

```
tests
├── testthat
│   └── test-scatter_plot.R
└── testthat.R

2 directories, 2 files
```

`usethis::use_vignette('test-specs')` adds the following to the `DESCRIPTION`:

```
VignetteBuilder: knitr
```

```
vignettes/
└── test-specs.Rmd

1 directory, 1 file
```

