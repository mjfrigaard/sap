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

## CSS 

### `18.0_css-inline`

[`18.0_css-inline`](https://github.com/mjfrigaard/moviesApp/tree/18.0_css-inline) gives examples of using inline CSS in your app-package.

### Package state 

This branch includes all the elements for the application up to and including System Tests. The `tests/testthat/_snaps/` folder has been removed, so when you run `devtools::test()` you should see something like the following: 

<details tests>

``` bash
ℹ Testing moviesApp
Loading required package: shiny
✔ | F W  S  OK | Context
✔ |   4      2 | app-feature-01 [11.2s]
──────────────────────────────
Warning (test-app-feature-01.R:20:17): Scenario A: Change dropdown values for plotting
             Given the movie review application is loaded
             When I choose the variable [critics_score] for the x-axis
             And I choose the variable [imdb_num_votes] for the y-axis
             And I choose the variable [genre] for the color: Then the scatter plot should show [critics_score] on the x-axis
             And the scatter plot should show [imdb_num_votes] on the y-axis
             And the points on the scatter plot should be colored by [genre]
Adding new file snapshot: 'tests/testthat/_snaps/feature-01-senario-a-001_.png'

Warning (test-app-feature-01.R:20:17): Scenario A: Change dropdown values for plotting
             Given the movie review application is loaded
             When I choose the variable [critics_score] for the x-axis
             And I choose the variable [imdb_num_votes] for the y-axis
             And I choose the variable [genre] for the color: Then the scatter plot should show [critics_score] on the x-axis
             And the scatter plot should show [imdb_num_votes] on the y-axis
             And the points on the scatter plot should be colored by [genre]
Adding new file snapshot: 'tests/testthat/_snaps/feature-01-senario-a-001.json'

Warning (test-app-feature-01.R:37:17): Scenario B: Change dropdown values for plotting
              Given the movie review application is loaded
              When I choose the size of the points to be [3]
              And I choose the opacity of the points to be [0.7]
              And I enter '[New plot title]' for the plot title: Then the size of the points on the scatter plot should be [3]
              And the opacity of the points on the scatter plot should be [0.7]
              And the title of the plot should be '[New plot title]'
Adding new file snapshot: 'tests/testthat/_snaps/feature-01-senario-b-001_.png'

Warning (test-app-feature-01.R:37:17): Scenario B: Change dropdown values for plotting
              Given the movie review application is loaded
              When I choose the size of the points to be [3]
              And I choose the opacity of the points to be [0.7]
              And I enter '[New plot title]' for the plot title: Then the size of the points on the scatter plot should be [3]
              And the opacity of the points on the scatter plot should be [0.7]
              And the title of the plot should be '[New plot title]'
Adding new file snapshot: 'tests/testthat/_snaps/feature-01-senario-b-001.json'
──────────────────────────────
⠏ |          0 | ggp2_app-feature-01
INFO [2024-03-15 11:02:16] [ START ggp2movies-feat-01 = update x, y, z, missing]
⠋ |   1      0 | ggp2_app-feature-01
INFO [2024-03-15 11:02:29] [ END ggp2movies-feat-01 = update x, y, z, missing]
✔ |   2      1 | ggp2_app-feature-01 [13.4s]
──────────────────────────────
Warning (test-ggp2_app-feature-01.R:28:7): Scenario: Change dropdown values for plotting
        Given the movie review application is loaded
        When I choose the variable ['Length'] for the x-axis
        And I choose the variable ['Rating'] for the y-axis
        And I choose the variable ['Genre'] for the color
        And I click the ['Remove missing'] checkbox: Then the scatter plot should show ['Length'] on the x-axis
        And the scatter plot should show ['Rating'] on the y-axis
        And the points on the scatter plot should be colored by ['Genre']
        And the missing values should be removed from the plot
Adding new file snapshot: 'tests/testthat/_snaps/ggp2movies_app-feature-01-001_.png'

Warning (test-ggp2_app-feature-01.R:28:7): Scenario: Change dropdown values for plotting
        Given the movie review application is loaded
        When I choose the variable ['Length'] for the x-axis
        And I choose the variable ['Rating'] for the y-axis
        And I choose the variable ['Genre'] for the color
        And I click the ['Remove missing'] checkbox: Then the scatter plot should show ['Length'] on the x-axis
        And the scatter plot should show ['Rating'] on the y-axis
        And the points on the scatter plot should be colored by ['Genre']
        And the missing values should be removed from the plot
Adding new file snapshot: 'tests/testthat/_snaps/ggp2movies_app-feature-01-001.json'
──────────────────────────────
⠏ |          0 | mod_scatter_display
INFO [2024-03-15 11:02:30] [ START display = selected_vars initial values]

INFO [2024-03-15 11:02:30] [ END display = selected_vars initial values]

INFO [2024-03-15 11:02:30] [ START display = scatterplot[['alt']] = 'Plot object']
⠙ |          2 | mod_scatter_display
INFO [2024-03-15 11:02:30] [ END display = scatterplot[['alt']] = 'Plot object']

INFO [2024-03-15 11:02:30] [ START display = inputs() creates ggplot2 object]

INFO [2024-03-15 11:02:30] [ END display = inputs() creates ggplot2 object]
✔ |          3 | mod_scatter_display
⠏ |          0 | mod_var_input
INFO [2024-03-15 11:02:30] [ START var_inputs = initial returned()]

INFO [2024-03-15 11:02:30] [ END var_inputs = initial returned()]

INFO [2024-03-15 11:02:30] [ START var_inputs = updated returned()]

INFO [2024-03-15 11:02:30] [ END var_inputs = updated returned()]
✔ |          2 | mod_var_input
⠏ |          0 | scatter_plot 
INFO [2024-03-15 11:02:30] [ START fixture = tidy_ggp2_movies.rds]

INFO [2024-03-15 11:02:30] [ START fixture = tidy_ggp2_movies.rds]

INFO [2024-03-15 11:02:30] [ START data = movies.rda]

INFO [2024-03-15 11:02:30] [ END data = movies.rda]
✔ |          2 | scatter_plot
✔ |   2      1 | shinytest2 [6.2s]
──────────────────────────────
Warning (test-shinytest2.R:11:3): {shinytest2} recording: feature-01
Adding new file snapshot: 'tests/testthat/_snaps/feature-01-001_.png'

Warning (test-shinytest2.R:11:3): {shinytest2} recording: feature-01
Adding new file snapshot: 'tests/testthat/_snaps/feature-01-001.json'
──────────────────────────────

══ Results ═══════════════════
Duration: 31.9 s

[ FAIL 0 | WARN 8 | SKIP 0 | PASS 11 ]

You rock!
```

</details>

The two applications in `moviesApp` can be run with `moviesApp()`

``` r
devtools::load_all()
library(moviesApp)
movies_app()
```

or 

``` r
movies_app(bslib = TRUE)
```


The `ggp2_movies_app()` function will launch the development application with the [`ggplot2movies` data](https://cran.r-project.org/web/packages/ggplot2movies/index.html):

``` r
moviesApp::ggp2_movies_app()
```