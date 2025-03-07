#' About Data Module UI
#'
#' UI function for the about data information module.
#'
#' @param id A character vector used to identify the namespace for this module
#'
#' @return A UI definition for the about data module
#'
#' @importFrom shiny NS p
#' @importFrom bslib card card_header card_body
#'
#' @export
aboutDataUI <- function(id) {
  ns <- NS(id)
  card(
    card_header("About the Data"),
    card_body(
      p("This application visualizes a sample of IMDB movie data. Select different 
        variables for the x and y axes, and optionally color and size the points 
        by other variables. You can also adjust the transparency of the points."),
      p("Data source: IMDB movie dataset with ratings, box office performance, and awards information.")
    )
  )
}
