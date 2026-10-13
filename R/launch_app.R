#' Launch the Movies Review Application
#'
#' Starts the Movies Review Shiny application, which provides a customizable
#' scatter plot interface for analyzing movie data.
#'
#' @param mode launch mode. Choices are:
#' *  run: blocking (default), returns app object
#' *  start: non-blocking, launches in background process
#' @param options Shiny options.
#' @param run where to launch the application. Choices are:
#' *  p: RStudio viewer pane
#' *  b: New browser window (default)
#' *  w: RStudio window
#' @param ... arguments passed to [shiny::startApp()]
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
launch_app <- function(mode = c("start", "run"), options = list(), run = "b", ...) {
  mode <- match.arg(mode)
  display_type(run = run)

  app <- shinyApp(
    ui = movies_ui(),
    server = movies_server,
    options = options
  )

  if (mode == "start") {
    return(shiny::startApp(app, ...))
  }
  app
}