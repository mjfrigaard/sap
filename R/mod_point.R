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
        cap = lab_formatter(as.character(vals()$c)),
        x_lbl = lab_formatter(as.character(vals()$x)),
        y_lbl = lab_formatter(as.character(vals()$y)),
        t = lab_formatter(as.character(vals()$t)),
        s = paste(
            lab_formatter(as.character(vals()$x)), 
            "vs.", lab_formatter(as.character(vals()$y)),
            "by", lab_formatter(as.character(vals()$c))
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
          color = !!vals()$c
        )
      ) +
        ggplot2::geom_point(
          alpha = vals()$a,
          size = vals()$s
        ) +
        ggplot2::labs(
          title = label_inputs()$t,
          subtitle = label_inputs()$s,
          x = label_inputs()$x,
          y = label_inputs()$y,
          color = label_inputs()$c
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
