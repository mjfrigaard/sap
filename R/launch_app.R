#' Launch the Movies Explorer Shiny Application
#'
#' @param options Shiny options.
#' @param mode launch mode. Choices are:
#' *  run: blocking (default)
#' *  start: non-blocking, launches in a background process
#' @param ... Additional arguments passed to shinyApp()
#' @return Shiny app object
#' @export
launch_app <- function(options = list(), mode = "run", ...) {
  # Load required packages
  library(shiny)
  library(bslib)
  library(ggplot2)
  library(reactable)
  library(rmarkdown)

  app <- shinyApp(
    ui = app_ui(),
    server = app_server,
    options = options,
    ...
  )

  if (mode == "start") {
    shiny::startApp(appDir = app, port = 3838)
  } else {
    shiny::runApp(appDir = app)
  }
}
