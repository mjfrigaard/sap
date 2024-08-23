#' plot_display UI
#'
#' @description A shiny Module.
#'
#' @param id Unique id for module instance.
#'
#' @return shiny UI module
#'
#' @export plot_displayUI
#'
plot_displayUI <- function(id) {
  ns <- NS(id)
  tagList(
    tags$br(),
    tags$blockquote(
      tags$em(
        tags$h6(
          "The code for this application comes from the ",
          tags$a("Building web applications with Shiny",
            href = "https://rstudio-education.github.io/shiny-course/"
          ),
          "tutorial"
        )
      )
    ),
    plotOutput(outputId = ns("scatterplot"))
  )
}

#' plot_display Server
#'
#' @param id Unique id for module instance.
#'
#' @keywords internal
plot_display_server <- function(id, var_inputs) {
  moduleServer(id, function(input, output, session) {

      ns <- session$ns
      send_message <- make_send_message(session)

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
            x = stringr::str_replace_all(
                  tools::toTitleCase(inputs()$x), "_", " "),
            y = stringr::str_replace_all(
                  tools::toTitleCase(inputs()$y), "_", " ")) +
          ggplot2::theme_minimal() +
          ggplot2::theme(legend.position = "bottom")
      })
    }
  )
}

# UI
# plot_displayUI('id')

# server
# plot_display_server('id')
