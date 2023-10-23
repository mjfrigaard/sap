# moviesApp

`moviesApp` provides the code examples for [Shiny App-Packages](https://mjfrigaard.github.io/shinyap/).

## Code for book

You can view the GitHub repository for the book [here](https://github.com/mjfrigaard/shinyap).

## `movies` app

The original code and data for this shiny app comes from the [Building Web Applications with Shiny](https://rstudio-education.github.io/shiny-course/) course.

I've converted it have [shiny modules](https://shiny.posit.co/r/articles/improve/modules/) and a [standalone app function](https://mastering-shiny.org/scaling-packaging.html#converting-an-existing-app) (which can be run from `app.R`).

# Branches

View the various versions of application in the [`moviesApp` branches](https://github.com/mjfrigaard/moviesApp/branches/all).

## `09_data`

[`09_data`](https://github.com/mjfrigaard/moviesApp/tree/09_data) covers the various ways to store data in your app-package.

Data for the package (internal, becomes part of the namespace)

```
data
├── movies.RData
└── movies.rda

1 directory, 2 files
```

External data files

```
inst
└── extdata
    └── movies.fst

2 directories, 1 file
```

