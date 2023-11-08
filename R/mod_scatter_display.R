#' Scatter plot display module (UI)
#'
#' @param id UI module id
#' 
#'
#' @return module UI (HTML)
#' 
#' @family {"scatter plot module functions"}
#' 
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
    plotOutput(outputId = ns("scatterplot")),
    # .dev output ----
    code('inputs() from display module'),
    verbatimTextOutput(ns("display_vals"))
  )
}

#' Scatter plot display module (server)
#' 
#'
#' @param id server module id 
#' @param rVals app `reactiveValues()`
#' @param .dev view dev output
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
mod_scatter_display_server <- function(id, rVals, .dev = FALSE) {
  
  moduleServer(id, function(input, output, session) {

    inputs <- reactive({
      plot_title <- tools::toTitleCase(rVals$inputs()[['plot_title']])
        list(
          x = rVals$inputs()[['x']],
          y = rVals$inputs()[['y']],
          z = rVals$inputs()[['z']],
          alpha = rVals$inputs()[['alpha']],
          size = rVals$inputs()[['size']],
          plot_title = plot_title
        )
    })
    
    output$scatterplot <- renderPlot({
      plot <- scatter_plot(
        # data --------------------
        df = moviesApp::movies,
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
    
    if (.dev) {
      # view output in the UI
      output$display_vals <- renderPrint({
        str(
          rVals$inputs()
          )
      })
    }
    
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
