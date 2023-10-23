# moviesApp

`moviesApp` provides the code examples for [Shiny App-Packages](https://mjfrigaard.github.io/shinyap/).

## Code for book

You can view the GitHub repository for the book [here](https://github.com/mjfrigaard/shinyap).

## `movies` app

The original code and data for this shiny app comes from the [Building Web Applications with Shiny](https://rstudio-education.github.io/shiny-course/) course.

I've converted it have [shiny modules](https://shiny.posit.co/r/articles/improve/modules/) and a [standalone app function](https://mastering-shiny.org/scaling-packaging.html#converting-an-existing-app) (which can be run from `app.R`).

# Branches

View the various versions of application in the [`moviesApp` branches](https://github.com/mjfrigaard/moviesApp/branches/all).

## Creating packages

The next two branches cover creating packages with `usethis::create_package()` and by manually editing the `DESCRIPTION` file.

### `06a_create-package`

After running `usethis::create_package()`, the `DESCRIPTION` file is updated with the following fields:

```
Package: moviesApp
Title: movies app
Version: 0.0.0.9000
Author: John Smith [aut, cre]
Maintainer: John Smith <John.Smith@email.io>
Description: A movie-review shiny application.
License: GPL-3
Encoding: UTF-8
Roxygen: list(markdown = TRUE)
RoxygenNote: 7.2.3
```

