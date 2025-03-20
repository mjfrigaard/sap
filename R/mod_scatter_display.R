#' scatter_display UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList
mod_scatter_display_ui <- function(id) {
  ns <- NS(id)
  tagList(
    tags$br(),
    plotOutput(outputId = ns("scatterplot"))
  )
}

#' scatter_display Server Functions
#'
#' @noRd
mod_scatter_display_server <- function(id, var_inputs, aes_inputs) {
  moduleServer(id, function(input, output, session){
    ns <- session$ns

    # observe({
    # browser()

    inputs <- reactive({
      plot_title <- tools::toTitleCase(aes_inputs()$plot_title)
        list(
          x = var_inputs()$x,
          y = var_inputs()$y,
          z = var_inputs()$z,
          alpha = aes_inputs()$alpha,
          size = aes_inputs()$size,
          plot_title = plot_title

        )
    })

    output$scatterplot <- renderPlot({
      plot <- scatter_plot(
        # data --------------------
        df = movies,
        x_var = inputs()$x,
        y_var = inputs()$y,
        col_var = inputs()$z,
        alpha_var = inputs()$alpha,
        size_var = inputs()$size
      )
      plot +
        ggplot2::labs(
          title = inputs()$plot_title,
            x = stringr::str_replace_all(tools::toTitleCase(inputs()$x), "_", " "),
            y = stringr::str_replace_all(tools::toTitleCase(inputs()$y), "_", " ")
        ) +
        ggplot2::theme_minimal() +
        ggplot2::theme(legend.position = "bottom")
    })

    # })

  })
}

## To be copied in the UI
# mod_scatter_display_ui("scatter_display_1")

## To be copied in the server
# mod_scatter_display_server("scatter_display_1")
