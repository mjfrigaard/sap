# set option to turn off loadSupport() ----
withr::with_options(new = list(shiny.autoload.r = FALSE), code = {
  if (!interactive()) {
    sink(stderr(), type = "output")
    tryCatch(
      expr = {
        library(moviesApp)
      },
      error = function(e) {
        pkgload::load_all()
      }
    )
    # create shiny object from prod/app ----
    shinyAppDir(appDir = 
                system.file("prod/app", package = "moviesApp"))
  } else {
    pkgload::load_all()
  }
  launch_app(options = list(test.mode = TRUE), run = 'p')
})
