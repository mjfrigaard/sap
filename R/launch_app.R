#' Launch the Shiny Application
#'
#' This function initializes and launches the Shiny application with specified 
#' options and settings.
#'
#' @param options A list of options for the `shinyApp` function.
#' @param run A character string specifying the display type, default is `"p"`.
#' @param ... Additional arguments passed to the UI function.
#'
#' @import shiny
#'
#' @export
launch_app <- function(options = list(), run = "p", ...) {
  
  if (interactive()) {
    display_type(run = run)
  }
    
    options(shiny.useragg = TRUE)
    
    logger::log_threshold(level = "INFO")
    
    ggplot2::theme_set(ggplot2::theme_minimal())
    
    thematic::thematic_shiny(
      bg = "#121212",
      fg = "#ffffff",
      accent = "#bdbdbd", 
      font = "auto")
    
    shinyApp(
      ui = nav_ui(...),
      server = nav_server,
      options = options
    )
    
}
