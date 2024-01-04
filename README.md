<h1 align="center"> <code>moviesApp</code> </h1>
<h3 align="center"> A Shiny App-Package </h3>
<h5 align="center"> Code examples for <a href="https://mjfrigaard.github.io/shinyap/"> Shiny App-Packages </a> </h5>

<hr>

# moviesApp

`moviesApp` provides the code examples in for the [Shiny App-Packages](https://mjfrigaard.github.io/shinyap/) book and the [Developing & Testing Your Shiny Application](https://mjfrigaard.github.io/dev-test-shiny/) workshop provided at R in Pharma (2023).

**Movie review data application**

The original code and data for the Shiny app comes from the [Building Web Applications with Shiny](https://rstudio-education.github.io/shiny-course/) course.

## Using code examples

The branches in this repo contain a Shiny application in the various stages of development. 

<p>
  If you're following along in the <a href="https://mjfrigaard.github.io/shiny-app-pkgs/">Shiny App-Packages</a> book, look for the Git Branch icon in the margin:
  <img src="https://raw.githubusercontent.com/mjfrigaard/shiny-app-pkgs/main/images/new_branch_ico.png" alt="Git branch icon" width="33%" fig-align="center">

</p>

----

<p>
You can change the branch in the Posit Workbench IDE's <strong>Git</strong> pane:

  <img src="https://raw.githubusercontent.com/mjfrigaard/shiny-app-pkgs/main/images/git_branches.gif" alt="Animated git branches" width="80%" fig-align="center">
  
</p>



Or use the terminal

``` bash
git checkout <branch_name>
```

------------------------------------------------------------------------

# Branches

View the various versions of application in the [`moviesApp` branches](https://github.com/mjfrigaard/moviesApp/branches/all).

## Creating packages

The next two branches cover creating packages with `usethis::create_package()` and by manually editing the `DESCRIPTION` file.

### `03.3_create-package`

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

