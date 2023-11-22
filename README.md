
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
#>    source         branch_name             updated
#> 1    <NA>                main 2023-10-25 08:12:48
#> 2  origin   01_whole-app-game 2023-11-21 10:53:52
#> 3  origin      02a_movies-app 2023-11-19 14:23:38
#> 4  origin        02b_proj-app 2023-11-17 14:50:17
#> 5  origin     03a_description 2023-11-02 13:35:02
#> 6  origin           03b_rproj 2023-11-02 13:35:17
#> 7  origin  03c_create-package 2023-11-02 13:35:34
#> 8  origin         04_devtools 2023-11-02 13:35:52
#> 9  origin         05_roxygen2 2023-11-17 14:53:36
#> 10 origin     06a_pkg-exports 2023-11-17 14:54:17
#> 11 origin     06b_pkg-imports 2023-11-17 14:54:52
#> 12 origin             07_data 2023-11-17 14:55:45
#> 13 origin       08_launch-app 2023-11-17 14:56:49
#> 14 origin        09a_inst-www 2023-11-17 14:57:48
#> 15 origin      09b_inst-bslib 2023-11-21 09:14:32
#> 16 origin        09c_inst-dev 2023-11-17 14:59:04
#> 17 origin       09d_inst-prod 2023-11-18 04:51:27
#> 18 origin      11_tests-specs 2023-11-18 05:30:29
#> 19 origin  12a_tests-fixtures 2023-11-18 05:31:06
#> 20 origin   12b_tests-helpers 2023-11-18 05:31:53
#> 21 origin     12f_tests-mocks 2023-11-18 05:34:25
#> 22 origin 12g_tests-snapshots 2023-11-18 05:35:09
#> 23 origin    13_tests-modules 2023-11-18 05:32:44
#> 24 origin     14_tests-system 2023-11-21 09:08:21
#> 25 origin            15_golem 2023-11-18 05:36:02
#> 26 origin       16_leprechaun 2023-11-10 12:35:13
#> 27 origin            17_rhino 2023-11-06 14:55:08
#> 28 origin       18a_debugging 2023-11-18 05:39:47
#> 29 origin       18b_debugging 2023-11-18 05:40:34
#> 30 origin       18c_debugging 2023-11-18 05:41:07
#> 31 origin       18d_debugging 2023-11-18 05:41:46
#> 32 origin       18e_debugging 2023-11-18 05:42:23
#> 33 origin 19a_reactive-values 2023-11-18 05:44:24
#> 34 origin       19b_user-data 2023-11-18 07:06:19
#> 35 origin  20_tests-snapshots 2023-11-18 05:35:09
#> 36 origin      21_tests-mocks 2023-11-18 05:34:25
#> 37 origin    22a_trace-matrix 2023-11-18 07:26:20
#> 38 origin                HEAD 2023-10-25 08:12:48
#> 39 origin                main 2023-10-25 08:12:48
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
launch_app(app = "02b_proj-app")
```

<img src="https://raw.githubusercontent.com/mjfrigaard/shinyap/main/man/figures/launch_app.gif" width="100%" style="display: block; margin: auto;" />


------------------------------------------------------------------------

# Current branch `03_proj-app`

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

