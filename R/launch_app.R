#' Launch the Shiny Application
#'
#' This function initializes and launches the Shiny application with specified
#' options and settings.
#'
#' @param options A list of options for the `shinyApp` function.
#' @param mode launch mode. Choices are:
#'  * `run` = blocking, uses [display_type()] for window placement (default)
#'  * `start` = non-blocking, launches in a background process
#' @param run A character string specifying the display type, default is `"p"`.
#' @param ... Additional arguments passed to the UI function.
#'
#' @import shiny
#'
#' @export
launch_app <- function(options = list(), mode = "run", run = "p", ...) {

    options(shiny.useragg = TRUE)

    logger::log_threshold(level = "DEBUG")

    ggplot2::theme_set(ggplot2::theme_minimal())

    thematic::thematic_shiny(
      bg = "#121212",
      fg = "#ffffff",
      accent = "#bdbdbd",
      font = "auto")

    app <- shinyApp(
      ui = nav_ui(...),
      server = nav_server,
      options = options
    )

    if (mode == "start") {
      shiny::startApp(appDir = app, port = 3838)
    } else {
      if (interactive()) {
        display_type(run = run)
      }
      shiny::runApp(appDir = app)
    }

}
