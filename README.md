<h1 align="center"> <code><strong>sap</strong></code> </h1>
<h3 align="center"> Code examples for <a href="https://mjfrigaard.github.io/shiny-app-pkgs/"> Shiny App-Packages </a> </h3>
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

## Tests 

### `13_tests-modules`

[`13_tests-modules`](https://github.com/mjfrigaard/sap/tree/13_tests-modules) gives examples of Shiny's `testServer()` function.

```
tests
├── testthat
│   ├── fixtures
│   │   ├── make-tidy_ggp2_movies.R
│   │   └── tidy_ggp2_movies.rds
│   ├── helper.R
│   ├── test-mod_scatter_display.R
│   ├── test-mod_var_input.R
│   └── test-scatter_plot.R
└── testthat.R

3 directories, 7 files
```

The results of devtools::test() are below: 

<details> 
<summary>View devtools::test()</summary>
```
==> devtools::test()

ℹ Testing sap
✔ | F W  S  OK | Context
Loading required package: shiny
⠏ |          0 | mod_scatter_display                                                    
INFO [2024-09-03 23:07:41] [ START display = selected_vars initial values]
⠋ |          1 | mod_scatter_display                                                    
INFO [2024-09-03 23:07:41] [ END display = selected_vars initial values]
INFO [2024-09-03 23:07:41] [ START display = scatterplot[['alt']] = 'Plot object']
⠙ |          2 | mod_scatter_display                                                    
INFO [2024-09-03 23:07:42] [ END display = scatterplot[['alt']] = 'Plot object']
INFO [2024-09-03 23:07:42] [ START display = inputs() creates ggplot2 object]
INFO [2024-09-03 23:07:42] [ END display = inputs() creates ggplot2 object]
INFO [2024-09-03 23:07:42] [ START mod_scatter_display 1 = output$scatterplot is a list]
INFO [2024-09-03 23:07:42] [ END mod_scatter_display 1 = output$scatterplot is a list]
INFO [2024-09-03 23:07:42] [ START mod_scatter_display 2 = names in output$scatterplot]
INFO [2024-09-03 23:07:42] [ END mod_scatter_display 2 = names in output$scatterplot]
✔ |          5 | mod_scatter_display [1.1s]
⠏ |          0 | mod_var_input                                                          
INFO [2024-09-03 23:07:42] [ START var_inputs = initial returned()]
INFO [2024-09-03 23:07:42] [ END var_inputs = initial returned()]
INFO [2024-09-03 23:07:42] [ START var_inputs = updated returned()]
INFO [2024-09-03 23:07:42] [ END var_inputs = updated returned()]
✔ |          2 | mod_var_input
⠏ |          0 | scatter_plot                                                           
INFO [2024-09-03 23:07:42] [ START fixture = tidy_ggp2_movies.rds]
INFO [2024-09-03 23:07:42] [ START fixture = tidy_ggp2_movies.rds]
INFO [2024-09-03 23:07:42] [ START data = sap::movies]
INFO [2024-09-03 23:07:42] [ END data = sap::movies]
✔ |          2 | scatter_plot
══ Results ═════════════════════════════════════════════════════════════════════
Duration: 1.3 s

[ FAIL 0 | WARN 0 | SKIP 0 | PASS 9 ]
```
</details>
