<h1 align="center"> <code><strong>sap</strong></code> </h1>
<h3 align="center"> Code examples for <a href="https://mjfrigaard.github.io/shiny-app-pkgs/"> Shiny App-Packages </a> </h3>
<hr>

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

Or use the terminal:

``` bash
git clone https://github.com/mjfrigaard/sap.git
cd sap
git checkout <branch_name>
open sap.Rproj
```

------------------------------------------------------------------------

# Branches

View all the applications in the [`sap` branches](https://github.com/mjfrigaard/sap/branches/all).

## `18_test-system`

[`18_test-system`](https://github.com/mjfrigaard/sap/tree/18_test-system) covers system tests with [`shinytest2`](https://rstudio.github.io/shinytest2/). 

The test results in this branch should show something *like* the following after loading, installing, and calling `devtools::test()`:


```{verbatim}
devtools::test()
ℹ Testing sap
✔ | F W  S  OK | Context
⠏ |          0 | mod_scatter_display_server                    
TEST: START [2025-02-17 21:29:29] COLLECT = collected module values

TEST: END [2025-02-17 21:29:29] COLLECT = collected module values

TEST: START [2025-02-17 21:29:29] OUTPUT = is list
⠙ |          2 | mod_scatter_display_server                    
TEST: END [2025-02-17 21:29:30] OUTPUT = is list

TEST: START [2025-02-17 21:29:30] OUTPUT = names

TEST: END [2025-02-17 21:29:30] OUTPUT = names

TEST: START [2025-02-17 21:29:30] OUTPUT = Plot object

TEST: END [2025-02-17 21:29:30] OUTPUT = Plot object

TEST: START [2025-02-17 21:29:30] OUTPUT = is ggplot
⠼ |          5 | mod_scatter_display_server                    
TEST: END [2025-02-17 21:29:30] OUTPUT = is ggplot
✔ |          5 | mod_scatter_display_server
⠏ |          0 | mod_var_input_server                          
TEST: START [2025-02-17 21:29:30] RETURNED = test_vals vs. session$returned()

TEST: END [2025-02-17 21:29:30] RETURNED = test_vals vs. session$returned()
✔ |          1 | mod_var_input_server
⠏ |          0 | scatter_plot                                  
TEST: START [2025-02-17 21:29:30] Step1 = loading movies data

TEST: END [2025-02-17 21:29:30] Step1 = movies data loaded successfully

TEST: START [2025-02-17 21:29:30] Step2 = creating graph

TEST: END [2025-02-17 21:29:30] Step2 = graph created
✔ |          1 | scatter_plot
✔ |          6 | shinytest2-export [4.4s]                      
⠏ |          0 | shinytest2-prod                               
TEST: START [2025-02-17 21:29:34] prod-feat-01 = update x, y, and z
⠋ |          1 | shinytest2-prod                               
TEST: END [2025-02-17 21:29:42] prod-feat-01 = update x, y, and z
✔ |          1 | shinytest2-prod [7.8s]
✔ |          2 | shinytest2 [12.0s]                            
⠏ |          0 | text_logo                                     
TEST: START [2025-02-17 21:29:54] snap = text_logo()

TEST: END [2025-02-17 21:29:54] snap = text_logo()

TEST: START [2025-02-17 21:29:54] snap = text_logo('})')
⠙ |          2 | text_logo                                     
TEST: START [2025-02-17 21:29:54] snap = text_logo('h1')

TEST: START [2025-02-17 21:29:54] snap = text_logo('invalid')

TEST: END [2025-02-17 21:29:54] snap = text_logo('invalid')
✔ |          3 | text_logo

══ Results ════════════════════════════════════════════════════
Duration: 25.2 s

[ FAIL 0 | WARN 0 | SKIP 0 | PASS 19 ]
```