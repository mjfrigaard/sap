#' User Interface for Horizontal Bar Plot
#'
#' @param id Shiny module ID.
#'
#' @return A UI for displaying a horizontal bar plot.
#' 
#' @section Outputs:
#' - `ratings`: Horizontal bar plot.
#'
#' @seealso [mod_vbar_server()]
#' 
#' @export
mod_vbar_ui <- function(id) {
  ns <- NS(id)
    tagList(
      plotOutput(outputId = ns("ratings"))
      # verbatimTextOutput(outputId = ns("ratings"))
    )
}

#' Server Logic for Horizontal Bar Plot
#'
#' @param id Shiny module ID.
#' @param vals Reactive list of plot parameters.
#'
#' @return Renders a horizontal bar plot based on selected parameters.
#' 
#' @section Reactive Inputs:
#' - `vals`: Reactive list of plot parameters.
#'
#' @seealso [mod_vbar_ui()]
#' 
#' @export
mod_vbar_server <- function(id, vals) {
  moduleServer(id, function(input, output, session) {
        
  output$ratings <- renderPlot({
      req(vals())
      tspan <- abs(vals()$start_year - vals()$end_year)
      t <- paste("Time span =", tspan, "years")
      d <- subset(movies, 
        thtr_rel_year >= vals()$start_year &
        thtr_rel_year <= vals()$end_year)
      ggplot2::ggplot(d,
        ggplot2::aes(mpaa_rating)) +
        ggplot2::geom_bar() +
        ggplot2::labs(
          title = t,
          y = "# of Movies", 
          x = "MPAA Rating") +
        ggplot2::theme_minimal()
    })
  
  })
}