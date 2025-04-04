#' scatter_display UI
#'
#' @param id Unique id for module instance.
#'
#' @keywords internal
scatter_displayUI <- function(id){
    ns <- NS(id)
  tagList(
    tags$br(),
    plotOutput(outputId = ns("scatterplot"))
  )
}

#' scatter_display Server
#'
#' @param id Unique id for module instance.
#' @param var_inputs variable inputs
#' @param aes_inputs aesthetic inputs
#'
#' @keywords internal
scatter_display_server <- function(id, var_inputs, aes_inputs){
    moduleServer(
        id,
        function(
            input,
            output,
            session
            ){

                ns <- session$ns
                send_message <- make_send_message(session)

    send_message <- make_send_message(session)
    send_message("show-packer",
      text = "a message from R/module_plot_display.R")

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
        }
    )
}

# UI
# scatter_displayUI('id')

# server
# scatter_display_server('id')
