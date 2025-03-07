#' UI Function for the Movie Visualization App
#'
#' Generates the UI for the IMDB movie visualization application.
#'
#' @return A Shiny UI object
#'
#' @importFrom bslib page_sidebar sidebar bs_theme
#' @importFrom shiny tagList
#'
#' @export
ui_function <- function() {
  # Create a dark theme using bslib
  dark_theme <- bs_theme(
    bg = "#202123",          # Background
    fg = "#FFFFFF",          # Foreground
    primary = "#3E72C4",     # Primary color
    secondary = "#3E5C76",   # Secondary color
    success = "#2E8B57",     # Success color
    base_font = "Helvetica"  # Font
  )
  
  page_sidebar(
    theme = dark_theme,
    title = "IMDB Movie Data Visualization",
    
    sidebar = sidebar(
      title = "Controls",
      controlsUI("movie_controls")
    ),
    
    # Main panel with output
    plotOutputUI("movie_plot"),
    aboutDataUI("about")
  )
}
