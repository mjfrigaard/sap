<h1 align="center"> <code>moviesApp</code> </h1>
<h3 align="center"> A Shiny App-Package </h3>
<h5 align="center"> Code examples for <a href="https://mjfrigaard.github.io/shinyap/"> Shiny App-Packages </a> </h5>

<hr>

# moviesApp

`moviesApp` provides the code examples in for the [Shiny App-Packages](https://mjfrigaard.github.io/shinyap/) book and the [Developing & Testing Your Shiny Application](https://mjfrigaard.github.io/dev-test-shiny/) workshop provided at R in Pharma (2023).

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

Or use the terminal

``` bash
git clone https://github.com/mjfrigaard/moviesApp.git
cd moviesApp
git checkout <branch_name>
open moviesApp.Rproj
```

------------------------------------------------------------------------

# Branches

View all the applications in the [`moviesApp` branches](https://github.com/mjfrigaard/moviesApp/branches/all).

## CI/CD (docker) 

### `20.3_cicd-docker`

[`20.3_cicd-docker`](https://github.com/mjfrigaard/moviesApp/tree/20.3_cicd-docker) gives examples of GitHub Actions workflows using Docker. Changes will only affect the CI/CD workflow in this branch. 

### `.github/workflows/docker.yaml`

```yaml
name: docker-shiny, moviesapp

on:
  push:
    branches: [ 20.3_cicd-docker ]

jobs:
  docker:
    runs-on: ubuntu-latest
    
    steps:
      - uses: actions/checkout@v3

      - name: Build image
        run: docker build -t moviesapp . 
      - name: execute
        run: >
          docker run 
          -e RSCONNECT_USER=${{secrets.RSCONNECT_USER}} 
          -e RSCONNECT_TOKEN=${{secrets.RSCONNECT_TOKEN}} 
          -e RSCONNECT_SECRET=${{secrets.RSCONNECT_SECRET}} 
          moviesapp  

```

### `Dockerfile`

``` bash
FROM rocker/shiny
RUN R -e 'install.packages(c("rlang", "stringr", "shiny", "ggplot2", "remotes", "rsconnect", "bslib"))'
RUN mkdir /home/moviesAppDockerCiCd
ADD . /home/moviesAppDockerCiCd
WORKDIR /home/moviesAppDockerCiCd
RUN R -e 'remotes::install_local(upgrade="never")'
EXPOSE 8180
CMD Rscript deploy.R
```

### `deploy.R`

``` r
rsconnect::setAccountInfo(name = Sys.getenv("RSCONNECT_USER"),
               token = Sys.getenv("RSCONNECT_TOKEN"),
               secret = Sys.getenv("RSCONNECT_SECRET"))

rsconnect::deployApp(appDir = ".", 
  appName = "moviesAppDockerCiCd", 
  account = "mjfrigaard", 
	server = "shinyapps.io", 
	forceUpdate = TRUE)
```
