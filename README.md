# moviesApp

`moviesApp` provides the code examples in the [Shiny App-Packages](https://mjfrigaard.github.io/shinyap/).

## Code for book

The GitHub repository for the book is [here](https://github.com/mjfrigaard/shinyap).

## `movies` app

The original code and data for this shiny app comes from the [Building Web Applications with Shiny](https://rstudio-education.github.io/shiny-course/) course.

I've converted it have [shiny modules](https://shiny.posit.co/r/articles/improve/modules/) and a [standalone app function](https://mastering-shiny.org/scaling-packaging.html#converting-an-existing-app) (which can be run from `app.R`).

# Branches

View the various versions of application in the [`moviesApp` branches](https://github.com/mjfrigaard/moviesApp/branches/all).

## `main`

The [`main`](https://github.com/mjfrigaard/moviesApp/tree/main) branch of `moviesApp` is identical to the files that are created with a new Shiny App from the Posit Workbench New Project Wizard.

## `02_movies-app`

The [`02_movies-app`](https://github.com/mjfrigaard/moviesApp/tree/02_movies-app) branch of `moviesApp` includes the code for the movie review data (from the [Building Web Applications with Shiny](https://rstudio-education.github.io/shiny-course/) course) in `app.R`.

## `03_proj-app`

The [`03_proj-app`](https://github.com/mjfrigaard/moviesApp/tree/03_proj-app) branch of `moviesApp` includes and `R/` folder and external resources have been included in `www`. 

```
R/
├── mod_scatter_display.R
├── mod_var_input.R
└── utils.R

1 directory, 3 files
```

```
www/
└── shiny.png

1 directory, 1 file
```


A `DESCRIPTION` file has also been added.

```
Type: shiny
Title: movies app
Author: John Smith
DisplayMode: Showcase
```



