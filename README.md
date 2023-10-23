# moviesApp

`moviesApp` provides the code examples for [Shiny App-Packages](https://mjfrigaard.github.io/shinyap/).

## Code for book

You can view the GitHub repository for the book [here](https://github.com/mjfrigaard/shinyap).

## `movies` app

The original code and data for this shiny app comes from the [Building Web Applications with Shiny](https://rstudio-education.github.io/shiny-course/) course.

I've converted it have [shiny modules](https://shiny.posit.co/r/articles/improve/modules/) and a [standalone app function](https://mastering-shiny.org/scaling-packaging.html#converting-an-existing-app) (which can be run from `app.R`).

# Branches

View the various versions of application in the [`moviesApp` branches](https://github.com/mjfrigaard/moviesApp/branches/all).


## `07_roxygen2`

The [`07_roxygen2`](https://github.com/mjfrigaard/moviesApp/tree/07_roxygen2) branch of `moviesApp` has documentation for all files in `R/`, and creates the help files in the `man/` folder:

```
man
├── mod_scatter_display_server.Rd
├── mod_scatter_display_ui.Rd
├── mod_var_input_server.Rd
├── mod_var_input_ui.Rd
├── movies_app.Rd
├── movies_server.Rd
├── movies_ui.Rd
└── scatter_plot.Rd

1 directory, 8 files
```

