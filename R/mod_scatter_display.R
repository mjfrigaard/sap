#' Scatter plot display module (UI)
#'
#' @param id UI module id
#' 
#'
#' @return module UI (HTML)
#' 
#' @family {"scatter plot module functions"}
#' 
#' @keywords internal
mod_scatter_display_ui <- function(id) {
  ns <- NS(id)
  tagList(
    tags$br(),
    tags$blockquote(
      tags$em(
        tags$h6("The data for this application comes from the ",
        tags$a("Building web applications with Shiny",
          href = "https://rstudio-education.github.io/shiny-course/"),
                      "tutorial"))
      ),
    plotOutput(outputId = ns("scatterplot"))
  )
}

#' Scatter plot display module (server)
#' 
#'
#' @param id server module id 
#' @param var_inputs returned reactive list from [mod_var_input_server()].
#' 
#' @section Referring to `var_inputs`: 
#' Refer to the reactive returned values from `mod_var_input_server()` as:
#'  * `var_inputs()$x`
#'  * `var_inputs()$y`
#'  * `var_inputs()$z`
#'  * `var_inputs()$alpha`
#'  * `var_inputs()$size`
#'  * `var_inputs()$plot_title`
#' 
#'
#' @return rendered plot and title output from [scatter_plot()]
#' 
#' @family {"scatter plot module functions"}
#' 
#' @keywords internal
mod_scatter_display_server <- function(id, var_inputs) {
  moduleServer(id, function(input, output, session) {

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
          x = stringr::str_replace_all(tools::toTitleCase(inputs()$x), "_", " "),
          y = stringr::str_replace_all(tools::toTitleCase(inputs()$y), "_", " ")
        ) +
        ggplot2::theme_minimal() +
        ggplot2::theme(legend.position = "bottom")
    })
    
    exportTestValues(
             x = { inputs()$x },
             y = { inputs()$y },
             z = { inputs()$z },
             alpha = { inputs()$alpha },
             size = { inputs()$size },
             title = { inputs()$plot_title }
    )
    
  })
}