# reset loadSupport() ----
# options(shiny.autoload.r = NULL)

# set option to turn off loadSupport() ----
withr::with_options(new = list(shiny.autoload.r = FALSE), code = {
  if (!interactive()) {
    sink(stderr(), type = "output")
    tryCatch(
      expr = {
        # load package ----
        library(sap)
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
    sap::ggp2_launch_app(
      options = list(test.mode = FALSE), run = 'p')
})
