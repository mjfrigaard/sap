#' Launch the Movies Review Application
#'
#' Starts the Movies Review Shiny application, which provides a customizable
#' scatter plot interface for analyzing movie data.
#' 
#' @param options Shiny options.
#' @param mode launch mode. Choices are:
#' *  run: blocking, uses [display_type()] for window placement (default)
#' *  start: non-blocking, launches in a background process
#' @param run where to launch the application. Choices are:
#' *  p: RStudio viewer pane
#' *  b: New browser window
#' *  w: RStudio window
#'
#' @return A **Shiny application** object.
#'
#' @section Details:
#' The application uses:
#' - **UI**: Defined in [`movies_ui()`].
#' - **Server Logic**: Defined in [`movies_server()`].
#'
#' @seealso
#' - [`movies_ui()`] for the user interface.
#' - [`movies_server()`] for the server logic.
#'
#' @family **Standalone Application**
#'
#' @examples
#' if (interactive()) {
#'   launch_app()
#' }
#'
#' 
#' @export
#' 
#' @import shiny
#' 
launch_app <- function(options = list(), mode = "run", run = "p") {
  app <- shinyApp(
    ui = movies_ui(),
    server = movies_server,
    options = options
  )

  if (mode == "start") {
    shiny::startApp(appDir = app, port = 3838)
  } else if (mode == "run") {
    display_type(run = run)
    shiny::runApp(appDir = app)
  }
}