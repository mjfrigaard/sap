#' Launch the Shiny Application
#'
#' This function initializes and launches the Shiny application with specified 
#' options and settings.
#'
#' @param options A list of options for the `shinyApp` function.
#' @param run A character string specifying the display type, default is `"p"`.
#' @param ... Additional arguments passed to the UI function.
#'
#' @details
#' `launch_app()` checks if the R session is interactive. If so, it sets the 
#' display type based on the `run` parameter. Then, it initializes and runs the
#' Shiny application using `shinyApp`, with the UI and server components 
#' provided by [navbar_ui()] and [navbar_server()], respectively.
#'
#' @section Parameters:
#' - `options`: A list of options passed to the `shinyApp` function.
#' - `run`: Display type for the app, default is `"p"`.
#' - `...`: Additional arguments passed to the UI function.
#'
#' @section Interactive Mode:
#' If the function is called in an interactive R session, it will set the 
#' display type using `display_type(run = run)`.
#'
#' @seealso [navbar_ui()], [navbar_server()]
#' 
#' @import shiny
#'
#' @export
launch_app <- function(options = list(), run = "p", ...) {
  if (interactive()) {
    display_type(run = run)
  }
    shinyApp(
      ui = navbar_ui(...),
      server = navbar_server,
      options = options
    )
}