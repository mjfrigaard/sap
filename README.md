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

### `12a_tests-specs`

[`12a_tests-specs`](https://github.com/mjfrigaard/moviesApp/tree/12a_tests-specs) covers working through a set of app specifications and building a traceability matrix. 

`usethis::use_testthat(3)` adds the following to the `DESCRIPTION`:

```
Config/testthat/edition: 3
```

Creating a new test file with `usethis::use_test("scatter_plot")`

```
tests
├── testthat
│   └── test-scatter_plot.R
└── testthat.R

2 directories, 2 files
```

`usethis::use_vignette('test-specs')` adds the following to the `DESCRIPTION`:

```
VignetteBuilder: knitr
```

```
vignettes/
└── test-specs.Rmd

1 directory, 1 file
```

