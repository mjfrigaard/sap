#' Launch the Movies Explorer Shiny Application
#'
#' @param ... Additional arguments passed to shinyApp()
#' @return Shiny app object
#' @export
launch_app <- function(...) {
  # Load required packages
  library(shiny)
  library(bslib)
  library(ggplot2)
  library(reactable)
  library(rmarkdown)

  # Create and run the app
  shinyApp(
    ui = app_ui(),
    server = app_server,
    ...
  )
}