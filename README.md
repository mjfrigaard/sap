
<!-- README.md is generated from README.Rmd. Please edit that file -->

# moviesApp

<!-- badges: start -->
<!-- badges: end -->

`moviesApp` provides an example of deploying an app-package website with
[`pkgdown`](https://pkgdown.r-lib.org/).

## Install

Install the development version of `moviesApp` using
[`pak`](https://pak.r-lib.org/):

``` r
install.packages('pak')
pak::pak("mjfrigaard/moviesApp")
```

## Launch

``` r
library(moviesApp)
movies_app()
```

### `pkgdown` setup

Install `pkgdown`:

``` r
pak::pak('pkgdown')
```

Set up GitHub Actions:

``` r
 usethis::use_pkgdown_github_pages()
```

Change the branches for the triggering event in
`.github/workflows/pkgdown.yml` to only trigger on the [`17_pkgdown`
branch](https://github.com/mjfrigaard/moviesApp/tree/17_pkgdown):

``` yml
on:
  push:
    branches: [17_pkgdown]
  pull_request:
    branches: [17_pkgdown]
```

Build site:

``` r
pkgdown::build_site_github_pages()
```

Add, commit, and push:

``` bash
git add .
git commit -m "updates to _pkgdown.yml"
git push
```

## Deployed site

View the deployed site here: <https://mjfrigaard.github.io/moviesApp/>

More information can be found on the **Actions** tab of the GitHub repo.

## Tests

The `tests/testthat/` folder contains unit, module, and system tests.
The results from `devtools::test()` should return the following (after
adding the snapshots):

<details closed>
<summary>
devtools::test()
</summary>
<pre>
ℹ Testing moviesApp
Loading required package: shiny
✔ | F W  S  OK | Context
✔ |          2 | app-feature-01 [14.9s]                                                    
⠏ |          0 | mod_scatter_display                                                       
INFO [2024-05-30 06:46:02] [ START display = selected_vars initial values]
&#10;INFO [2024-05-30 06:46:02] [ END display = selected_vars initial values]
&#10;INFO [2024-05-30 06:46:02] [ START display = scatterplot[['alt']] = 'Plot object']
⠙ |          2 | mod_scatter_display                                                       
INFO [2024-05-30 06:46:03] [ END display = scatterplot[['alt']] = 'Plot object']
&#10;INFO [2024-05-30 06:46:03] [ START display = inputs() creates ggplot2 object]
&#10;INFO [2024-05-30 06:46:03] [ END display = inputs() creates ggplot2 object]
✔ |          3 | mod_scatter_display
⠏ |          0 | mod_var_input                                                             
INFO [2024-05-30 06:46:03] [ START var_inputs = initial returned()]
&#10;INFO [2024-05-30 06:46:03] [ END var_inputs = initial returned()]
&#10;INFO [2024-05-30 06:46:03] [ START var_inputs = updated returned()]
&#10;INFO [2024-05-30 06:46:03] [ END var_inputs = updated returned()]
✔ |          2 | mod_var_input
⠏ |          0 | scatter_plot                                                              
INFO [2024-05-30 06:46:03] [ START fixture = tidy_ggp2_movies.rds]
&#10;INFO [2024-05-30 06:46:03] [ START fixture = tidy_ggp2_movies.rds]
&#10;INFO [2024-05-30 06:46:03] [ START data = movies.rda]
&#10;INFO [2024-05-30 06:46:03] [ END data = movies.rda]
✔ |          2 | scatter_plot
✔ |          1 | shinytest2 [8.4s]                                                         
&#10;══ Results ══════════════════════════════════════════════════════════════════
Duration: 24.1 s
&#10;[ FAIL 0 | WARN 0 | SKIP 0 | PASS 10 ]
    </pre>
</details>

### Movie review data application

`moviesApp` provides the code examples in for the [Shiny
App-Packages](https://mjfrigaard.github.io/shinyap/) book and the
[Developing & Testing Your Shiny
Application](https://mjfrigaard.github.io/dev-test-shiny/) workshop
provided at R in Pharma (2023). The original code and data for the Shiny
app comes from the [Building Web Applications with
Shiny](https://rstudio-education.github.io/shiny-course/) course.
