#' User Interface for Vertical Bar Plot
#'
#' @param id Shiny module ID.
#'
#' @return A UI for displaying a vertical bar plot.
#' 
#' @section Outputs:
#' - `genre`: Vertical bar plot.
#'
#' @seealso [mod_hbar_server()]
#' 
#' @export
#' 
mod_hbar_ui <- function(id) {
  ns <- NS(id)
    tagList(
      verbatimTextOutput(outputId = ns("genre"))
    )
}

#' Server Logic for Vertical Bar Plot
#'
#' @param id Shiny module ID.
#' @param vals Reactive list of plot parameters.
#'
#' @return Renders a vertical bar plot based on selected parameters.
#' 
#' @section Reactive Inputs:
#' - `vals`: Reactive list of plot parameters.
#'
#' @seealso [mod_hbar_ui()]
#' 
#' @export
mod_hbar_server <- function(id, vals) {
  moduleServer(id, function(input, output, session) {
    
    output$genre <- renderPrint({
      req(vals())
      str(
        abs(vals()$start_year - vals()$end_year)
        )
      
    # genre_data <- subset(movies, thtr_rel_year == pvals()$year)
    
    #   ggplot2::ggplot(data = genre_data, 
    #     ggplot2::aes(genre)) +
    #     ggplot2::geom_bar() +
    #     ggplot2::coord_flip() +
    #     ggplot2::labs(y = "# of Movies", x = "Genre") +
    #     ggplot2::theme_minimal()
  })

  })
}