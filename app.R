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
    # create shiny object from dev/ ----
    shinyAppDir(appDir = 
                system.file("dev", package = "moviesApp"))
  } else {
    pkgload::load_all()
  }
  moviesApp::ggp2_movies_app()
})