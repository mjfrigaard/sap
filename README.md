
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
#>                  branch        last_updated
#> 1        02.1_shiny-app 2023-11-22 00:17:49
#> 2     01_whole-app-game 2023-11-22 00:23:27
#> 3       02.1_movies-app 2023-11-22 00:24:21
#> 4        02.1_shiny-app 2023-11-22 00:17:49
#> 5       02.2_movies-app 2023-11-22 00:24:21
#> 6         02.2_proj-app 2023-11-22 00:26:46
#> 7         02.3_proj-app 2023-11-22 00:26:46
#> 8      03.1_description 2023-12-06 14:28:52
#> 9            03.2_rproj 2023-11-02 13:35:17
#> 10  03.3_create-package 2023-11-02 13:35:34
#> 11          04_devtools 2023-11-02 13:35:52
#> 12          05_roxygen2 2023-11-17 15:53:36
#> 13     06.1_pkg-exports 2023-11-17 15:54:17
#> 14     06.2_pkg-imports 2023-11-17 15:54:52
#> 15              07_data 2023-12-08 20:15:19
#> 16        08_launch-app 2023-11-17 15:56:49
#> 17        09.1_inst-www 2023-11-17 15:57:48
#> 18      09.2_inst-bslib 2023-11-21 10:14:32
#> 19        09.3_inst-dev 2023-11-17 15:59:04
#> 20       09.4_inst-prod 2023-11-18 05:51:27
#> 21       11_tests-specs 2023-11-18 06:30:29
#> 22  12.1_tests-fixtures 2023-11-18 06:31:06
#> 23   12.2_tests-helpers 2023-11-18 06:31:53
#> 24     13_tests-modules 2023-11-18 06:32:44
#> 25      14_tests-system 2023-11-21 10:08:21
#> 26            15_docker 2023-11-21 10:08:21
#> 27             18_golem 2023-11-18 06:36:02
#> 28        19_leprechaun 2023-11-10 13:35:13
#> 29             20_rhino 2023-12-30 21:49:09
#> 30       21.1_debugging 2023-11-18 06:39:47
#> 31       21.2_debugging 2023-11-18 06:40:34
#> 32       21.3_debugging 2023-11-18 06:41:07
#> 33       21.4_debugging 2023-11-18 06:41:46
#> 34       21.5_debugging 2023-11-18 06:42:23
#> 35 22.1_reactive-values 2023-11-18 06:44:24
#> 36       22.2_user-data 2023-11-18 08:06:19
#> 37   22_reactive-values 2023-11-18 06:44:24
#> 38         22_user-data 2023-11-18 08:06:19
#> 39   23_tests-snapshots 2023-11-18 06:35:09
#> 40       24_tests-mocks 2023-11-18 06:34:25
#> 41                 HEAD 2023-11-22 00:17:49
#> 42                 main 2023-11-22 00:17:49
#> 43      st_trace-matrix 2023-11-18 08:26:20
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

The [`main`](https://github.com/mjfrigaard/moviesApp/tree/main) branch of `moviesApp` is identical to the files that are created with a new Shiny App from the Posit Workbench New Project Wizard.

```         
├── README.md
├── app.R
├── movies.RData
├── moviesApp.Rproj
└── utils.R

1 directory, 5 files
```
