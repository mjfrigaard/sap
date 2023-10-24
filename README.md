# moviesApp

`moviesApp` provides the code examples for [Shiny App-Packages](https://mjfrigaard.github.io/shinyap/).

## Code for book

You can view the GitHub repository for the book [here](https://github.com/mjfrigaard/shinyap).

## `movies` app

The original code and data for this shiny app comes from the [Building Web Applications with Shiny](https://rstudio-education.github.io/shiny-course/) course.

I've converted it have [shiny modules](https://shiny.posit.co/r/articles/improve/modules/) and a [standalone app function](https://mastering-shiny.org/scaling-packaging.html#converting-an-existing-app) (which can be run from `app.R`).

# Branches

View the various versions of application in the [`moviesApp` branches](https://github.com/mjfrigaard/moviesApp/branches/all).

## Special topic: Debugging 

### `spec_topic-debugging-01`

The [`spec_topic-debugging-01`](https://github.com/mjfrigaard/moviesApp/tree/spec_topic-debugging-01) branch is the first step of 4 that demonstrate debugging an error in `movies_app()`. 

This branch should be loaded, documented, and installed, then the application should be launched: 

```r
library(moviesApp)
movies_app(run = 'p')
```

Error in the app: 

```
Error: [object Object]
```

Error in the Console: 

```
Warning: Error in ggplot2::geom_point: Problem while computing aesthetics.
ℹ Error occurred in the 1st layer.
Caused by error in `.data[[NULL]]`:
! Must subset the data pronoun with a string, not `NULL`.
```