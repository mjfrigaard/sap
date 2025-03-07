#' IMDB Movie Visualization Shiny App
#'
#' A Shiny application for visualizing IMDB movie data with interactive controls
#' for customizing scatter plots.
#'
#' @return A Shiny application object
#'
#' @importFrom shiny shinyApp
#'
#' @export
movie_visualization_app <- function() {
  # Create and return the Shiny app
  shinyApp(ui = ui_function(), server = server_function)
}