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

### `11a_inst-www`

[`11a_inst-www`](https://github.com/mjfrigaard/moviesApp/tree/11a_inst-www) shows how to add external resources in your app-package (i.e., the files previously stored in `www/`).

```
inst
├── extdata
│   └── movies.fst
└── www
    └── shiny.png

3 directories, 2 files
```
