# set option to turn off loadSupport() ----
withr::with_options(new = list(shiny.autoload.r = FALSE), code = {
  if (!interactive()) {
    sink(stderr(), type = "output")
    tryCatch(
      expr = {
        library(shinyrPkgs)
      },
      error = function(e) {
        pkgload::load_all()
      }
    )
    shinyAppDir(appDir = 
                system.file("prod/app", package = "shinyrPkgs"))
  } else {
    pkgload::load_all()
  }
  shinyrPkgs::launch_app(options = list(test.mode = TRUE), 
    run = 'p')
})
