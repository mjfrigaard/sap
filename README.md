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

### `12g_tests-snapshots`

[`12g_tests-snapshots`](https://github.com/mjfrigaard/moviesApp/tree/12g_tests-snapshots) gives examples snapshot tests with [`vdiffr`](https://vdiffr.r-lib.org/)

```
tests
├── testthat
│   ├── _snaps
│   │   └── scatter_plot
│   │       ├── initial-x-y-z-axes.svg
│   │       └── updated-x-y-color.svg
│   ├── fixtures
│   │   ├── make-tidy_ggp2_movies.R
│   │   └── tidy_ggp2_movies.rds
│   ├── helper.R
│   └── test-scatter_plot.R
└── testthat.R

5 directories, 7 files
```
