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
#' @export
#' 
server_function <- function(input, output, session) {
  # Load the data
  movies_data <- reactive({
    movies_sample <- vroom::vroom(file = "https://raw.githubusercontent.com/mjfrigaard/sap/refs/heads/23_llm-shiny-assist/data-raw/movies_sample.csv")
    return(movies_sample)
  })
  
  # Get controls from the controls module
  controls <- controlsServer("movie_controls")
  
  # Create the plot using the plot module
  plotOutputServer("movie_plot", movies_data, controls)
}
