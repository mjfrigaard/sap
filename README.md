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

## `19_docker` 

[`19_docker`](https://github.com/mjfrigaard/shinyAppPkgs/tree/19_docker) gives examples of using [Docker](https://www.docker.com/).

### Tests 

This branch has 10 tests (and the following results). The `tests/testthat/_snaps` folder has been removed.

<details closed>

  <summary>
    `devtools::test()` results 
  </summary>
  
```
==> devtools::test()

ℹ Testing shinyAppPkgs
Loading required package: shiny
✔ | F W  S  OK | Context
✔ |          2 | app-feature-01 [12.4s]
⠏ |          0 | mod_scatter_display
INFO [2024-05-22 14:32:29] [ START display = selected_vars initial values]

INFO [2024-05-22 14:32:29] [ END display = selected_vars initial values]

INFO [2024-05-22 14:32:29] [ START display = scatterplot[['alt']] = 'Plot object']
⠙ |          2 | mod_scatter_display
INFO [2024-05-22 14:32:30] [ END display = scatterplot[['alt']] = 'Plot object']

INFO [2024-05-22 14:32:30] [ START display = inputs() creates ggplot2 object]

INFO [2024-05-22 14:32:30] [ END display = inputs() creates ggplot2 object]
✔ |          3 | mod_scatter_display
⠏ |          0 | mod_var_input
INFO [2024-05-22 14:32:30] [ START var_inputs = initial returned()]

INFO [2024-05-22 14:32:30] [ END var_inputs = initial returned()]

INFO [2024-05-22 14:32:30] [ START var_inputs = updated returned()]

INFO [2024-05-22 14:32:30] [ END var_inputs = updated returned()]
✔ |          2 | mod_var_input
⠏ |          0 | scatter_plot 
INFO [2024-05-22 14:32:30] [ START fixture = tidy_ggp2_movies.rds]

INFO [2024-05-22 14:32:30] [ START fixture = tidy_ggp2_movies.rds]

INFO [2024-05-22 14:32:30] [ START data = movies.rda]

INFO [2024-05-22 14:32:30] [ END data = movies.rda]
✔ |          2 | scatter_plot
✔ |          1 | shinytest2 [7.2s]

══ Results ═══════════════════
Duration: 20.3 s

[ FAIL 0 | WARN 0 | SKIP 0 | PASS 10 ]
Warning message:
In warn_if_app_dir_is_package(appDir) :
  Loading R/ subdirectory for Shiny application, but this directory appears to contain an R package. Sourcing files in R/ may cause unexpected behavior. See `?loadSupport` for more details.
```
</details> 