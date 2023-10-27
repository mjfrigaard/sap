#' plot UI Function
#'
#' @param id module namespace id
#'
#' @return shiny UI module
#'
mod_plot_ui <- function(id) {
  ns <- NS(id)
  tagList(
    tags$br(),
      plotOutput(outputId = ns("scatterplot"))
  )
}

#' plot Server Functions
#'
#' @param id module namespace id
#' @param var_inputs inputs from mod_var
#'
#' @return shiny server module
#'
#'
mod_plot_server <- function(id, var_inputs) {
  moduleServer(id, function(input, output, session) {
    movies <- movies

    inputs <- reactive({
      plot_title <- tools::toTitleCase(var_inputs()$plot_title)
      list(
        x = var_inputs()$x,
        y = var_inputs()$y,
        z = var_inputs()$z,
        alpha = var_inputs()$alpha,
        size = var_inputs()$size,
        plot_title = plot_title
      )
    })

    output$scatterplot <- renderPlot({
      plot <- point_plot(
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
  })
}

## To be copied in the UI
# mod_plot_ui("plot_1")

## To be copied in the server
# mod_plot_server("plot_1")
