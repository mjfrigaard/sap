#' User Interface for Scatter Plot
#'
#' @param id Shiny module ID.
#'
#' @return A UI for displaying a scatter plot.
#' 
#' @section Outputs:
#' - `scatter`: Scatter plot.
#'
#' @seealso [mod_compare_point_server()]
#' 
#' @export
mod_compare_point_ui <- function(id) {
  ns <- NS(id)
  tagList(
    plotly::plotlyOutput(ns("scatter"),
      width = '100%', height = '100%')
  )
}

#' Server Logic for Scatter Plot
#'
#' @param id Shiny module ID.
#' @param vals Reactive list of plot parameters.
#'
#' @return Renders a scatter plot based on selected parameters.
#' 
#' @section Reactive Inputs:
#' - `vals`: Reactive list of plot parameters.
#'
#' @seealso [mod_compare_point_ui()]
#' 
#' @export
#' 
mod_compare_point_server <- function(id, vals) {
  moduleServer(id, function(input, output, session) {
    
    label_inputs <- reactive({
      req(vals()$x, vals()$y, vals()$c)
      list(
        x = name_case(as.character(vals()$x)),
        y = name_case(as.character(vals()$y)),
        color = name_case(as.character(vals()$color)),
        title = name_case(as.character(vals()$title)),
        subtitle = paste(
            name_case(as.character(vals()$x)), 
            "vs.", name_case(as.character(vals()$y)),
            "and", name_case(as.character(vals()$c))
          )
      )
    })

    output$scatter <- plotly::renderPlotly({
      req(vals())
      
      plotly::plot_ly(
        data = movies,
        x = ~get(vals()$x),
        y = ~get(vals()$y),
        color = ~get(vals()$color),
        text = ~title,
        type = 'scatter',
        mode = 'markers',
        colors = clr_pal3,
        marker = list(
          size = vals()$size,
          opacity = vals()$alpha
        )
      ) |>
        plotly::layout(
          title = list(
            text = label_inputs()$title,
            font = list(color = "#e0e0e0")  
          ),
          xaxis = list(
            title = label_inputs()$x,
            titlefont = list(color = "#e0e0e0"),  
            tickfont = list(color = "#e0e0e0")   
          ),
          yaxis = list(
            title = label_inputs()$y,
            titlefont = list(color = "#e0e0e0"),  
            tickfont = list(color = "#e0e0e0")   
          ),
          legend = list(
            font = list(color = "#e0e0e0")        
          ),
          plot_bgcolor = "#121212",    
          paper_bgcolor = "#121212"    
        )
    })
    
  })
}
