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

### `14_tests-system`

[`14_tests-system`](https://github.com/mjfrigaard/sap/tree/14_tests-system) gives examples of [`shinytest2` tests.](https://rstudio.github.io/shinytest2/articles/shinytest2.html).

The following system tests have been written for `sap`:

``` sh
tests/testthat/
  ├── test-app-feature-01.R
  ├── test-ggp2_app-feature-01.R
  └── test-shinytest2.R
```

After documenting, loading, and installing `sap`, `devtools::test()` will generate the following `tests/testthat/_snaps` folder: 

``` sh
tests/testthat/_snaps/
├── app-feature-01
│   ├── feature-01-senario-a-001.json
│   ├── feature-01-senario-a-001_.png
│   ├── feature-01-senario-b-001.json
│   └── feature-01-senario-b-001_.png
├── ggp2_app-feature-01
│   ├── ggp2launch_app-feature-01-001.json
│   └── ggp2launch_app-feature-01-001_.png
└── shinytest2
    ├── feature-01-001.json
    └── feature-01-001_.png
```

After the `_snaps/` have been created, `devtools::test()` will return the following: 

<details>
<summary>View devtools::test()</summary>
```
ℹ Testing sap
Loading required package: shiny
✔ | F W  S  OK | Context
✔ |          2 | app-feature-01 [10.1s]                               
⠏ |          0 | ggp2_app-feature-01                                      
INFO [2024-09-03 23:15:37] [ START ggp2movies-feat-01 = update x, y, z, missing]
⠋ |          1 | ggp2_app-feature-01                                                
INFO [2024-09-03 23:16:42] [ END ggp2movies-feat-01 = update x, y, z, missing]
✔ |          1 | ggp2_app-feature-01 [65.3s]
⠏ |          0 | mod_scatter_display                                    
INFO [2024-09-03 23:16:42] [ START display = selected_vars initial values]
INFO [2024-09-03 23:16:42] [ END display = selected_vars initial values]
INFO [2024-09-03 23:16:42] [ START display = scatterplot[['alt']] = 'Plot object']
⠙ |          2 | mod_scatter_display                                                
INFO [2024-09-03 23:16:43] [ END display = scatterplot[['alt']] = 'Plot object']
INFO [2024-09-03 23:16:43] [ START display = inputs() creates ggplot2 object]
INFO [2024-09-03 23:16:43] [ END display = inputs() creates ggplot2 object]
✔ |          3 | mod_scatter_display
⠏ |          0 | mod_var_input                                            
INFO [2024-09-03 23:16:43] [ START var_inputs = initial returned()]
INFO [2024-09-03 23:16:43] [ END var_inputs = initial returned()]
INFO [2024-09-03 23:16:43] [ START var_inputs = updated returned()]
INFO [2024-09-03 23:16:43] [ END var_inputs = updated returned()]
✔ |          2 | mod_var_input
⠏ |          0 | scatter_plot                                 
INFO [2024-09-03 23:16:43] [ START fixture = tidy_ggp2_movies.rds]
INFO [2024-09-03 23:16:43] [ END fixture = tidy_ggp2_movies.rds]
INFO [2024-09-03 23:16:43] [ START data = movies.rda]
INFO [2024-09-03 23:16:43] [ END data = movies.rda]
✔ |          2 | scatter_plot
✔ |          1 | shinytest2 [5.2s]                                              

══ Results ════════════════════════════════════════════════════════════════════
Duration: 81.4 s

[ FAIL 0 | WARN 0 | SKIP 0 | PASS 11 ]

🥳
```
</details>
