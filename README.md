# moviesApp

`moviesApp` provides the code examples for [Shiny App-Packages](https://mjfrigaard.github.io/shinyap/).

## Code for book

You can view the GitHub repository for the book [here](https://github.com/mjfrigaard/shinyap).

## `movies` app

The original code and data for this shiny app comes from the [Building Web Applications with Shiny](https://rstudio-education.github.io/shiny-course/) course.

I've converted it have [shiny modules](https://shiny.posit.co/r/articles/improve/modules/) and a [standalone app function](https://mastering-shiny.org/scaling-packaging.html#converting-an-existing-app) (which can be run from `app.R`).

# Branches

View the various versions of application in the [`moviesApp` branches](https://github.com/mjfrigaard/moviesApp/branches/all).

## Tests 

### `12e_tests-system`

[`12e_tests-system`](https://github.com/mjfrigaard/moviesApp/tree/12e_tests-system) gives examples of [`shinytest2` tests.](https://rstudio.github.io/shinytest2/articles/shinytest2.html)

```
tests
├── testthat
│   ├── fixtures
│   │   ├── make-tidy_ggp2_movies.R
│   │   └── tidy_ggp2_movies.rds
│   ├── helper.R
│   ├── setup-shinytest2.R
│   ├── test-feature-01.R
│   ├── test-mod_scatter_display.R
│   ├── test-mod_var_input.R
│   ├── test-scatter_plot.R
│   └── test-shinytest2.R
└── testthat.R

3 directories, 10 files
```
