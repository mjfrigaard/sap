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

The `spec_topic-debugging-02` branch is the second step of 4 on debugging. This branch should also be loaded, documented, installed and the application should be launched: 

```r
devtools::load_all()
```

```
ℹ Loading moviesApp
```

```r
devtools::document()
```

```
ℹ Updating moviesApp documentation
ℹ Loading moviesApp
Documentation completed
```

```r
devtools::install()
```

```
==> R CMD INSTALL --preclean --no-multiarch --with-keep.source moviesApp

* installing to library ‘/Library/Frameworks/R.framework/Versions/4.3-x86_64/Resources/library’
* installing *source* package ‘moviesApp’ ...
** using staged installation
** R
** data
*** moving datasets to lazyload DB
** inst
** byte-compile and prepare package for lazy loading
** help
*** installing help indices
** building package indices
** testing if installed package can be loaded from temporary location
** testing if installed package can be loaded from final location
** testing if installed package keeps a record of temporary installation path
* DONE (moviesApp)
```

```
Restarting R session...
```

```r
library(moviesApp)
movies_app(run = 'p')
```


