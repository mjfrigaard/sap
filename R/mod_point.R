#' User Interface for Scatter Plot
#'
#' @param id Shiny module ID.
#'
#' @return A UI for displaying a scatter plot.
#' 
#' @section Outputs:
#' - `scatter`: Scatter plot.
#'
#' @seealso [mod_point_server()]
#' 
#' @export
mod_point_ui <- function(id) {
  ns <- NS(id)
  tagList(
    plotOutput(ns("scatter"))
    # dev
    # verbatimTextOutput(
    #   outputId = ns("mod_vals"))
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
#' @seealso [mod_point_ui()]
#' 
#' @export
#' 
mod_point_server <- function(id, vals) {
  moduleServer(id, function(input, output, session) {
    
    label_inputs <- reactive({
      req(vals()$x, vals()$y, vals()$c)
      list(
        x = title_labs(as.character(vals()$x)),
        y = title_labs(as.character(vals()$y)),
        color = title_labs(as.character(vals()$color)),
        subtitle = title_labs(as.character(vals()$subtitle)),
        title = paste(
            title_labs(as.character(vals()$x)), 
            "vs.", title_labs(as.character(vals()$y)),
            "and", title_labs(as.character(vals()$c))
          )
      )
    })
    
    output$scatter <- renderPlot({
      req(vals())
      ggplot2::ggplot(
        movies,
        ggplot2::aes(
          y = !!vals()$y,
          x = !!vals()$x,
          color = !!vals()$color
        )
      ) +
        ggplot2::geom_point(
          alpha = vals()$alpha,
          size = vals()$size
        ) +
        ggplot2::labs(
          title = label_inputs()$title,
          subtitle = label_inputs()$subtitle,
          x = label_inputs()$x,
          y = label_inputs()$y,
          color = label_inputs()$color
        ) +
        ggplot2::theme_minimal() +
        ggplot2::theme(legend.position = "right")
    })
    # dev
    # output$mod_vals <- renderPrint({
    #   str(label_inputs())
    # })
  })
}
