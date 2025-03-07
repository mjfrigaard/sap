#' Server Function for the Movie Visualization App
#'
#' Coordinates the server logic for the IMDB movie visualization application.
#'
#' @param input Shiny input object
#' @param output Shiny output object
#' @param session Shiny session object
#'
#' @return None
#'
#' @importFrom readr read_csv
#' @importFrom shiny reactive
#'
#' @export
server_function <- function(input, output, session) {
  # Load the data
  movies_data <- reactive({
    read_csv("https://raw.githubusercontent.com/mjfrigaard/sap/refs/heads/23_llm-shiny-assist/inst/shiny-assist/movies/movies_sample.csv")
  })
  
  # Get controls from the controls module
  controls <- controlsServer("movie_controls")
  
  # Create the plot using the plot module
  plotOutputServer("movie_plot", movies_data, controls)
}
