# reset loadSupport() ----
# options(shiny.autoload.r = NULL)

# set option to turn off loadSupport() ----
withr::with_options(new = list(shiny.autoload.r = FALSE), code = {
  if (!interactive()) {
    sink(stderr(), type = "output")
    tryCatch(
      expr = {
        # load package ----
        library(moviesApp)
      },
      error = function(e) {
        # load R/ folder ----
        pkgload::load_all()
      }
    )
  } else {
    # load R/ folder ----
    pkgload::load_all()
  }
  # create shiny object ----
  moviesApp::movies_app(options = list(test.mode = TRUE), run = 'p')
})
