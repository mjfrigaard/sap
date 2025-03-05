<h1 align="center"> <code><strong>sap</strong></code> </h1>
<h3 align="center"> Code examples for <a href="https://mjfrigaard.github.io/shiny-app-pkgs/"> Shiny App-Packages </a> </h3>
<hr>

<hr>

# sap

`sap` provides the code examples in for the [Shiny App-Packages](https://mjfrigaard.github.io/shiny-app-pkgs/) book and the [Developing & Testing Your Shiny Application](https://mjfrigaard.github.io/dev-test-shiny/) workshop provided at R in Pharma (2023).

## Movie review data application

The original code and data for the Shiny app comes from the [Building Web Applications with Shiny](https://rstudio-education.github.io/shiny-course/) course.

# Using code examples

The branches in this repo contain a Shiny application in the various stages of development. The best way to access each branch/app is with the [`shinypak` package](https://mjfrigaard.github.io/shinypak/). 

```r
# install.packages("pak")
pak::pak("mjfrigaard/shinypak")
library(shinypak)
```

List all the apps with `list_apps()`


```r
head(list_apps())
#>                  branch        last_updated
#> 2     01_whole-app-game 2024-01-01 14:11:32
#> 1        02.1_shiny-app 2024-01-04 13:05:58
#> 4       02.2_movies-app 2024-01-04 13:07:59
#> 5         02.3_proj-app 2024-01-04 13:08:58
#> 6      03.1_description 2024-01-04 13:10:00
#> 7            03.2_rproj 2024-01-04 13:25:06
```

Launch an app with `launch()`

```r
launch(app = "02.3_proj-app")
```

Or use the terminal:

``` bash
git clone https://github.com/mjfrigaard/sap.git
cd sap
git checkout <branch_name>
open sap.Rproj
```

------------------------------------------------------------------------

# Branches

View all the applications in the [`sap` branches](https://github.com/mjfrigaard/sap/branches/all).

## `21.2_gha-shiny-docker`

[`21.2_gha-shiny-docker`](https://github.com/mjfrigaard/sap/tree/21.2_gha-shiny-docker) demonstrates how to use GitHub Actions to deploy a Shiny app using docker. 

The `shiny-docker.yaml` workflow is stored in the hidden `.github` folder:

``` sh
.github/
  └── workflows
      └── shiny-docker.yaml

2 directories, 1 file
```

The `.github/workflows/shiny-docker.yaml` file contains the following:

```yaml
name: docker-shiny, sap

on:
  push:
    branches: [ 21.3_gha-shiny-docker ]

jobs:
  docker:
    runs-on: ubuntu-latest
    
    steps:
      - uses: actions/checkout@v4

      - name: Build image
        run: docker build -t sap .

      - name: execute
        run: >
          docker run -e RSCONNECT_USER=${{ secrets.RSCONNECT_USER }} -e RSCONNECT_TOKEN=${{ secrets.RSCONNECT_TOKEN }}  -e RSCONNECT_SECRET=${{ secrets.RSCONNECT_SECRET }} sap  
```

A `deploy.R` is used to launch the app: 

```r
library(rsconnect)
rsconnect::setAccountInfo(name = Sys.getenv("RSCONNECT_USER"),
               token = Sys.getenv("RSCONNECT_TOKEN"),
               secret = Sys.getenv("RSCONNECT_SECRET"))
rsconnect::deployApp(appDir = ".", 
  appName = "shinyAppPkgsDockerCiCd", 
  account = "mjfrigaard", 
    server = "shinyapps.io", 
    forceUpdate = TRUE)
```

The `Dockerfile` includes the following: 

```
FROM rocker/shiny
RUN mkdir /home/shinyAppPkgsDockerCiCd
ADD . /home/shinyAppPkgsDockerCiCd
WORKDIR /home/shinyAppPkgsDockerCiCd
RUN R -e 'install.packages(c("bslib", "cli", "ggplot2", "logger", "pkgload", "quarto", "remotes", "rlang", "rsconnect", "sass", "shiny", "shinythemes", "stringr", "tools", "withr"))'
RUN R -e 'remotes::install_local(upgrade="never")'
EXPOSE 8180
CMD Rscript deploy.R
```