# set option to turn off loadSupport() ----
withr::with_options(new = list(shiny.autoload.r = FALSE), code = {
  if (!interactive()) {
    sink(stderr(), type = "output")
    tryCatch(
      expr = {
        library(sap)
      },
      error = function(e) {
        pkgload::load_all()
      }
    )
    shinyAppDir(appDir = 
                system.file("prod/app", package = "sap"))
  } else {
    pkgload::load_all()
  }
  sap::launch_app(options = list(test.mode = TRUE), 
    run = 'p')
})
