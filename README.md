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

## GitHub Actions 

### `16.2_cicd-shiny`

[`16.2_cicd-shiny`](https://github.com/mjfrigaard/moviesApp/tree/16.2_cicd-shiny) gives an example of a [Shiny workflow](https://github.com/r-lib/actions/tree/v2/examples#shiny-app-deployment).

```yaml
# Workflow derived from https://github.com/r-lib/actions/tree/v2/examples
# Need help debugging build failures? Start at https://github.com/r-lib/actions#where-to-find-help
on:
  push:
    branches: [16.2_cicd-shiny]

name: shiny

jobs:
  shiny:
    runs-on: ubuntu-latest
    env:
      GITHUB_PAT: ${{ secrets.GITHUB_TOKEN }}
    steps:
      - uses: actions/checkout@v3

      - uses: r-lib/actions/setup-pandoc@v2

      - uses: r-lib/actions/setup-r@v2
        with:
          use-public-rspm: true

      - uses: r-lib/actions/setup-renv@v2

      - name: Install rsconnect
        run: install.packages("rsconnect")
        shell: Rscript {0}

      - name: Authorize and deploy app
        env: 
          # Provide your app name, account name, and server to be deployed below
          APPNAME: moviesAppCICD
          ACCOUNT: mjfrigaard
          SERVER: shinyapps.io # server to deploy
        run: |
          rsconnect::setAccountInfo("${{ secrets.RSCONNECT_USER }}", "${{ secrets.RSCONNECT_TOKEN }}", "${{ secrets.RSCONNECT_SECRET }}")
          rsconnect::deployApp(appName = "${{ env.APPNAME }}", account = "${{ env.ACCOUNT }}", server = "${{ env.SERVER }}")
        shell: Rscript {0}

```

Be sure to configure the Github repository secrets for RSCONNECT_USER, RSCONNECT_TOKEN, and RSCONNECT_SECRET and your shinyapps.io account allows for private repo access.
