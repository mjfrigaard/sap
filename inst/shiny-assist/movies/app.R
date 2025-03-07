# Load required libraries
library(shiny)
library(ggplot2)
library(dplyr)
library(readr)
library(bslib)
library(thematic)

# Setup thematic to automatically adjust plot theme to match app theme
thematic_shiny(font = "auto")

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

# Run the application 
movie_visualization_app()
