
<!-- README.md is generated from README.Rmd. Please edit that file -->

# moviesApp (`21_pkgdown` branch)

<!-- badges: start -->
<!-- badges: end -->

`moviesApp` provides the code examples in for the [Shiny
App-Packages](https://mjfrigaard.github.io/shinyap/) book and the
[Developing & Testing Your Shiny
Application](https://mjfrigaard.github.io/dev-test-shiny/) workshop
provided at R in Pharma (2023).

## Movie review data application

The original code and data for the Shiny app comes from the [Building
Web Applications with
Shiny](https://rstudio-education.github.io/shiny-course/) course.

## Using code examples

The branches in this repo contain a Shiny application in the various
stages of development. The best way to access each branch/app is with
the [`shinypak` package](https://mjfrigaard.github.io/shinypak/).

``` r
# install.packages("pak")
pak::pak("mjfrigaard/shinypak")
library(shinypak)
```

List all the apps with `list_apps()`

``` r
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

``` r
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

### `21_pkgdown`

[`21_pkgdown`](https://github.com/mjfrigaard/moviesApp/tree/21_pkgdown)
gives examples of deploying a package website with
[`21_pkgdown`](https://pkgdown.r-lib.org/).

``` r
install.packages('pak')
pak::pak('pkgdown')
```

``` r
 usethis::use_pkgdown_github_pages()
```

    ✔ Setting active project to '/Users/mjfrigaard/projects/apps/moviesApp'
    ✔ Adding '^_pkgdown\\.yml$', '^docs$', '^pkgdown$' to '.Rbuildignore'
    ✔ Adding 'docs' to '.gitignore'
    ✔ Writing '_pkgdown.yml'
    • Modify '_pkgdown.yml'
    ✔ Initializing empty, orphan 'gh-pages' branch in GitHub repo 'mjfrigaard/moviesApp'
    ✔ GitHub Pages is publishing from:
    • URL: 'https://mjfrigaard.github.io/moviesApp/'
    • Branch: 'gh-pages'
    • Path: '/'
    ✔ Creating '.github/'
    ✔ Adding '^\\.github$' to '.Rbuildignore'
    ✔ Adding '*.html' to '.github/.gitignore'
    ✔ Creating '.github/workflows/'
    ✔ Saving 'r-lib/actions/examples/pkgdown.yaml@v2' to '.github/workflows/pkgdown.yaml'
    • Learn more at <https://github.com/r-lib/actions/blob/v2/examples/README.md>.
    ✔ Recording 'https://mjfrigaard.github.io/moviesApp/' as site's url in '_pkgdown.yml'
    ✔ Adding 'https://mjfrigaard.github.io/moviesApp/' to URL
    ✔ Setting 'https://mjfrigaard.github.io/moviesApp/' as homepage of GitHub repo 'mjfrigaard/moviesApp'

``` r
pkgdown::build_site_github_pages()
```

    11 Cleaning files from old site 11111111111111111111111111111111111111111111111
    == Building pkgdown site ======================================================
    Reading from: '/Users/mjfrigaard/projects/apps/moviesApp'
    Writing to:   '/Users/mjfrigaard/projects/apps/moviesApp/docs'
    -- Initialising site ----------------------------------------------------------
    Copying '../../../Library/Caches/org.R-project.R/R/renv/library/moviesApp-af14169e/R-4.3/x86_64-apple-darwin20/pkgdown/BS3/assets/bootstrap-toc.css' to 'bootstrap-toc.css'
    Copying '../../../Library/Caches/org.R-project.R/R/renv/library/moviesApp-af14169e/R-4.3/x86_64-apple-darwin20/pkgdown/BS3/assets/bootstrap-toc.js' to 'bootstrap-toc.js'
    Copying '../../../Library/Caches/org.R-project.R/R/renv/library/moviesApp-af14169e/R-4.3/x86_64-apple-darwin20/pkgdown/BS3/assets/docsearch.css' to 'docsearch.css'
    Copying '../../../Library/Caches/org.R-project.R/R/renv/library/moviesApp-af14169e/R-4.3/x86_64-apple-darwin20/pkgdown/BS3/assets/docsearch.js' to 'docsearch.js'
    Copying '../../../Library/Caches/org.R-project.R/R/renv/library/moviesApp-af14169e/R-4.3/x86_64-apple-darwin20/pkgdown/BS3/assets/link.svg' to 'link.svg'
    Copying '../../../Library/Caches/org.R-project.R/R/renv/library/moviesApp-af14169e/R-4.3/x86_64-apple-darwin20/pkgdown/BS3/assets/pkgdown.css' to 'pkgdown.css'
    Copying '../../../Library/Caches/org.R-project.R/R/renv/library/moviesApp-af14169e/R-4.3/x86_64-apple-darwin20/pkgdown/BS3/assets/pkgdown.js' to 'pkgdown.js'
    -- Building home --------------------------------------------------------------
    Writing 'authors.html'
    Writing '404.html'
    -- Building function reference ------------------------------------------------
    Writing 'reference/index.html'
    Reading 'man/display_type.Rd'
    Writing 'reference/display_type.html'
    Reading 'man/ggp2_movies_app.Rd'
    Writing 'reference/ggp2_movies_app.html'
    Reading 'man/mod_scatter_display_server.Rd'
    Writing 'reference/mod_scatter_display_server.html'
    Reading 'man/mod_scatter_display_ui.Rd'
    Writing 'reference/mod_scatter_display_ui.html'
    Reading 'man/mod_var_input_server.Rd'
    Writing 'reference/mod_var_input_server.html'
    Reading 'man/mod_var_input_ui.Rd'
    Writing 'reference/mod_var_input_ui.html'
    Reading 'man/movies.Rd'
    Writing 'reference/movies.html'
    Reading 'man/movies_app.Rd'
    Writing 'reference/movies_app.html'
    Reading 'man/movies_server.Rd'
    Writing 'reference/movies_server.html'
    Reading 'man/movies_ui.Rd'
    Writing 'reference/movies_ui.html'
    Reading 'man/scatter_plot.Rd'
    Writing 'reference/scatter_plot.html'
    Reading 'man/test_logger.Rd'
    Writing 'reference/test_logger.html'
    -- Building articles ----------------------------------------------------------
    Writing 'articles/index.html'
    Reading 'vignettes/test-specs.Rmd'
    Registered S3 methods overwritten by 'callr':
      method                    from
      format.callr_status_error     
      print.callr_status_error      
    Writing 'articles/test-specs.html'
    Writing 'sitemap.xml'
    == DONE ======================================================================
    -- Extra files for GitHub pages ----------------------------------------------
