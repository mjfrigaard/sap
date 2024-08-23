<h1 align="center"> <code><strong>shinyrPkgs</strong></code> </h1>
<h3 align="center"> Code examples for <a href="https://mjfrigaard.github.io/shiny-app-pkgs/"> Shiny App-Packages </a> </h3>
<hr>

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

## `18_golem`

Checkout the `18_golem` branch:

```bash
git checkout 18_golem
```

Load, document, and install the package:

```r
devtools::load_all()

devtools::document()

devtools::install()
```

## Run

You can run the application with the following:

``` r
library(gap)
gap::run_app()
```

## Code of Conduct

Please note that the `gap` project is released with a [Contributor Code of Conduct](https://contributor-covenant.org/version/2/1/CODE_OF_CONDUCT.html).
By contributing to this project, you agree to abide by its terms.

## Tests 

The results from the **2nd** call of `devtools::test()` should return: 

```
==> devtools::test()

ℹ Testing gap
Loading required package: shiny
✔ | F W  S  OK | Context
✔ |          2 | app-feature-01 [10.2s]                                                     
✔ |         13 | golem_utils_server                                                         
✔ |         51 | golem_utils_ui                                                             
✔ |      1  10 | golem-recommended                                                          
⠏ |          0 | mod_scatter_display                                                        
INFO [2024-08-23 07:45:37] [ START display = selected_vars initial values]

INFO [2024-08-23 07:45:37] [ END display = selected_vars initial values]

INFO [2024-08-23 07:45:37] [ START display = scatterplot[['alt']] = 'Plot object']
⠙ |          2 | mod_scatter_display                                                        
INFO [2024-08-23 07:45:38] [ END display = scatterplot[['alt']] = 'Plot object']

INFO [2024-08-23 07:45:38] [ START display = inputs() creates ggplot2 object]

INFO [2024-08-23 07:45:38] [ END display = inputs() creates ggplot2 object]
✔ |          3 | mod_scatter_display
⠏ |          0 | mod_var_input                                                              
INFO [2024-08-23 07:45:38] [ START var_inputs = initial returned()]

INFO [2024-08-23 07:45:38] [ END var_inputs = initial returned()]

INFO [2024-08-23 07:45:38] [ START var_inputs = updated returned()]

INFO [2024-08-23 07:45:38] [ END var_inputs = updated returned()]
✔ |          2 | mod_var_input
✔ |          1 | shinytest2 [5.1s]                                                          
⠏ |          0 | utils_mod_scatter_display                                                  
INFO [2024-08-23 07:45:43] [ START fixture = tidy_ggp2_movies.rds]

INFO [2024-08-23 07:45:43] [ START fixture = tidy_ggp2_movies.rds]

INFO [2024-08-23 07:45:43] [ START data = movies.rda]

INFO [2024-08-23 07:45:43] [ END data = movies.rda]
✔ |          2 | utils_mod_scatter_display

══ Results ════════════════════════════════════════════════════════════════════
Duration: 16.4 s

── Skipped tests (1) ──────────────────────────────────────────────────────────
• interactive() is not TRUE (1): test-golem-recommended.R:66:5

[ FAIL 0 | WARN 0 | SKIP 1 | PASS 84 ]
```