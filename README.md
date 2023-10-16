# moviesApp

`moviesApp` provides the code examples for [Shiny App-Packages](https://mjfrigaard.github.io/shinyap/).

## Code for book

You can view the GitHub repository for the book [here](https://github.com/mjfrigaard/shinyap).

## `movies` app

The original code and data for this shiny app comes from the [Building Web Applications with Shiny](https://rstudio-education.github.io/shiny-course/) course.

I've converted it have [shiny modules](https://shiny.posit.co/r/articles/improve/modules/) and a [standalone app function](https://mastering-shiny.org/scaling-packaging.html#converting-an-existing-app) (which can be run from `app.R`).

# Branches

View the various versions of application in the [`moviesApp` branches](https://github.com/mjfrigaard/moviesApp/branches/all).

## `05_rproj`

The `moviesApp.Rproj` file now contains the following fields: 

```
Version: 1.0

RestoreWorkspace: Default
SaveWorkspace: Default
AlwaysSaveHistory: Default

EnableCodeIndexing: Yes
UseSpacesForTab: Yes
NumSpacesForTab: 2
Encoding: UTF-8

RnwWeave: Sweave
LaTeX: XeLaTeX

BuildType: Package
PackageUseDevtools: Yes
PackageInstallArgs: --no-multiarch --with-keep.source
PackageRoxygenize: rd,collate,namespace
```

## `04_description`

The [`04_description`](https://github.com/mjfrigaard/moviesApp/tree/04_description) branch of `moviesApp` has an updated `DESCRIPTION` file:

```
Package: moviesApp
Title: movies app
Version: 0.0.0.9000
Author: John Smith [aut, cre]
Maintainer: John Smith <John.Smith@email.io>
Description: A movie-review shiny application.
License: GPL-3
```

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

## `02_movies-app`

The [`02_movies-app`](https://github.com/mjfrigaard/moviesApp/tree/02_movies-app) branch of `moviesApp` includes the code for the movie review data (from the [Building Web Applications with Shiny](https://rstudio-education.github.io/shiny-course/) course) in `app.R`.

## `main`

The [`main`](https://github.com/mjfrigaard/moviesApp/tree/main) branch of `moviesApp` is identical to the files that are created with a new Shiny App from the Posit Workbench New Project Wizard.

