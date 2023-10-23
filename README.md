# moviesApp

`moviesApp` provides the code examples for [Shiny App-Packages](https://mjfrigaard.github.io/shinyap/).

## Code for book

You can view the GitHub repository for the book [here](https://github.com/mjfrigaard/shinyap).

## `movies` app

The original code and data for this shiny app comes from the [Building Web Applications with Shiny](https://rstudio-education.github.io/shiny-course/) course.

I've converted it have [shiny modules](https://shiny.posit.co/r/articles/improve/modules/) and a [standalone app function](https://mastering-shiny.org/scaling-packaging.html#converting-an-existing-app) (which can be run from `app.R`).

# Branches

View the various versions of application in the [`moviesApp` branches](https://github.com/mjfrigaard/moviesApp/branches/all).

## External resources 

### `11b_inst-bslib`

[`11b_inst-bslib`](https://github.com/mjfrigaard/moviesApp/tree/11b_inst-bslib) covers how to store external files use the application UI function to display alternative versions of your app.

```
inst
├── extdata
│   └── movies.fst
└── www
    ├── bootstrap.png
    └── shiny.png

3 directories, 3 files
```

