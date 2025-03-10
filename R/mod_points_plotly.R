#' Scatter-plot (plotly) shiny module (UI)
#'
#' @param id shiny module id
#'
#' @export
#' 
mod_points_plotly_ui <- function(id) {
  ns <- shiny::NS(id)
    shiny::tagList(
      plotly::plotlyOutput(ns("graph"))
    )
  }
#' Scatter-plot (plotly) shiny module (server)
#'
#' @param id shiny module id
#' 
#' @export
#' 
mod_points_plotly_server <- function(id, data, vars) {
  shiny::moduleServer(id, function(input, output, session) {
    ns <- session$ns

      output$graph <- plotly::renderPlotly({
         xvar <- vars()[['xvar']]
         yvar <- vars()[['yvar']]
         df <- data()[[1]]
        scatter_plotly(
          data = df,
          xvar = xvar,
          yvar = yvar,
          colvar =  'has_oscar')
      })

  })
}

