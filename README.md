<h1 align="center">
<code>moviesApp</code>
</h1>
<h3 align="center">
A Shiny App-Package
</h3>
<h5 align="center">
Code examples for
<a href="https://mjfrigaard.github.io/shiny-app-pkgs/"> Shiny
App-Packages </a>
</h5>
<hr>

# moviesApp

`moviesApp` provides the code examples in for the [Shiny App-Packages](https://mjfrigaard.github.io/shiny-app-pkgs/) book and the [Developing & Testing Your Shiny Application](https://mjfrigaard.github.io/dev-test-shiny/) workshop provided at R in Pharma (2023).

## Movie review data

`moviesApp` has been adapted from the the [Building Web Applications with Shiny](https://rstudio-education.github.io/shiny-course/) course.

## Application branches

The [branches](https://github.com/mjfrigaard/moviesApp/branches/all) in the `moviesApp` repo contain Shiny applications in various stages of development. If you’re following along in the <a href="https://mjfrigaard.github.io/shiny-app-pkgs/">Shiny
App-Packages</a> book, look for the Git Branch icon in the margin:

<div>
<p align="right">
<img src="https://raw.githubusercontent.com/mjfrigaard/shiny-app-pkgs/main/images/new_branch_ico.png" alt="Git branch icon" width="33%">
</div>

<p align="left">
You can change the branch in the Posit Workbench IDE’s <strong>Git</strong> pane.
</p>

<div>
<p align="center">
<img src="https://raw.githubusercontent.com/mjfrigaard/shiny-app-pkgs/main/images/change_branches.gif" alt="Animated git branches" width="100%">
</p>
</div>

In the Terminal, change branches with:

<div>
<p align="right">

``` bash
git checkout branch_name
```

</div>


## Accessing apps

The `shinyap` R package provides quick access to the branches in `moviesApp`:

``` r
# install.packages("pak")
pak::pak("mjfrigaard/shinyap")
```

``` r
library(shinyap)
```

### List apps 

``` r
list_apps()
```

### Get app

``` r
get_app(app = "14_test-system")
```

<img src="https://raw.githubusercontent.com/mjfrigaard/shinyap/main/man/figures/get_app.gif" width="100%" style="display: block; margin: auto;" />

``` r
get_app(app = "14_test-system", open = TRUE)
```

<img src="https://raw.githubusercontent.com/mjfrigaard/shinyap/main/man/figures/get_app_open.gif" width="100%" style="display: block; margin: auto;" />

### Launch app

``` r
launch_app(app = "02.2_proj-app")
```

<img src="https://raw.githubusercontent.com/mjfrigaard/shinyap/main/man/figures/launch_app.gif" width="100%" style="display: block; margin: auto;" />


------------------------------------------------------------------------

# Current branch `main`

The [`02.1_shiny-app`](https://github.com/mjfrigaard/moviesApp/tree/02.1_shiny-app) branch of `moviesApp` is identical to the files that are created with a new Shiny App from the Posit Workbench New Project Wizard.

```         
├── README.md
├── app.R
├── movies.RData
├── moviesApp.Rproj
└── utils.R

1 directory, 5 files
```
