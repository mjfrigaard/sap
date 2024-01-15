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

## `21.5_debug-print`

The [`21.5_debug-print`](https://github.com/mjfrigaard/moviesApp/tree/21.5_debug-print) shows how to add 'print' statements in the application UI. 

## Structure 

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
    │   │   ├── app-feature-01
    │   │   │   ├── feature-01-senario-a-001.json
    │   │   │   ├── feature-01-senario-a-001_.png
    │   │   │   ├── feature-01-senario-b-001.json
    │   │   │   └── feature-01-senario-b-001_.png
    │   │   ├── ggp2_app-feature-01
    │   │   │   ├── ggp2movies_app-feature-01-001.json
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

20 directories, 56 files
```

</details>

## Tests 

<details>

```
==> devtools::test()

ℹ Testing moviesApp
Loading required package: shiny
✔ | F W  S  OK | Context
✔ |          2 | app-feature-01 [11.4s]                                                       
⠏ |          0 | ggp2_app-feature-01                                                          
INFO [2024-01-15 09:56:20] [ START ggp2movies-feat-01 = update x, y, z, missing]
⠋ |          1 | ggp2_app-feature-01                                                          
INFO [2024-01-15 09:56:57] [ END ggp2movies-feat-01 = update x, y, z, missing]
✔ |          1 | ggp2_app-feature-01 [37.4s]
⠏ |          0 | mod_scatter_display                                                          
INFO [2024-01-15 09:56:57] [ START display = selected_vars initial values]

INFO [2024-01-15 09:56:57] [ END display = selected_vars initial values]

INFO [2024-01-15 09:56:57] [ START display = scatterplot[['alt']] = 'Plot object']
⠙ |          2 | mod_scatter_display                                                          
INFO [2024-01-15 09:56:58] [ END display = scatterplot[['alt']] = 'Plot object']

INFO [2024-01-15 09:56:58] [ START display = inputs() creates ggplot2 object]

INFO [2024-01-15 09:56:58] [ END display = inputs() creates ggplot2 object]
✔ |          3 | mod_scatter_display
⠏ |          0 | mod_var_input                                                                
INFO [2024-01-15 09:56:58] [ START var_inputs = initial returned()]

INFO [2024-01-15 09:56:58] [ END var_inputs = initial returned()]

INFO [2024-01-15 09:56:58] [ START var_inputs = updated returned()]
⠙ |          2 | mod_var_input                                                                
INFO [2024-01-15 09:56:58] [ END var_inputs = updated returned()]
✔ |          2 | mod_var_input
⠏ |          0 | scatter_plot                                                                 
INFO [2024-01-15 09:56:58] [ START fixture = tidy_ggp2_movies.rds]

INFO [2024-01-15 09:56:58] [ START fixture = tidy_ggp2_movies.rds]

INFO [2024-01-15 09:56:58] [ START data = movies.rda]

INFO [2024-01-15 09:56:58] [ END data = movies.rda]
✔ |          2 | scatter_plot
✔ |          1 | shinytest2 [6.6s]                                                            

══ Results ═══════════════════════════════════════════════════════════════════════════════════
Duration: 56.2 s

[ FAIL 0 | WARN 0 | SKIP 0 | PASS 11 ]

🧿 Your tests look perfect 🧿
```

</details>