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
    # create shiny object from dev/ ----
    shinyAppDir(appDir = 
                system.file("dev", package = "shinyAppPkgs"))
  } else {
    pkgload::load_all()
    shinyAppPkgs::ggp2_launch_app(options = list(test.mode = FALSE))
  }
})
