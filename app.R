# set option to turn off loadSupport() ----
withr::with_options(new = list(shiny.autoload.r = FALSE), code = {
  if (!interactive()) {
    sink(stderr(), type = "output")
    tryCatch(
      expr = {
        library(shinyAppPkgs)
      },
      error = function(e) {
        pkgload::load_all()
      }
    )
    shinyAppDir(appDir = 
                system.file("prod/app", package = "shinyAppPkgs"))
  } else {
    pkgload::load_all()
  }
  shinyAppPkgs::launch_app(options = list(test.mode = TRUE), 
    run = 'p')
})
