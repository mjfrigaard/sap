#' Scatter Plot Display Module - UI
#'
#' Creates a UI for displaying a scatter plot with user-selected options.
#'
#' @param id *(character)* Namespace ID for the module.
#'
#' @return A `shiny::tagList` containing the plot output and metadata.
#'
#' @section Details: 
#' `mod_scatter_display_ui()` includes:
#' - A **scatter plot** created dynamically based on user input.
#' - Metadata about the app, including the data source.
#'
#' @seealso
#' - [`mod_scatter_display_server()`]  for the server-side logic of this 
#'   module.
#' - [`scatter_plot()`]  for the utility function generating the plot.
#'
#' @family **Plot Display Module**
#'
#' @examples
#' if (interactive()) {
#'   shiny::shinyApp(
#'     ui = shiny::fluidPage(mod_scatter_display_ui("plot")),
#'     server = function(input, output, session) {
#'       # Example usage - server logic is minimal for standalone testing.
#'     }
#'   )
#' }
#'
#' 
#' @export
mod_scatter_display_ui <- function(id) {
  ns <- NS(id)
  tagList(
    tags$br(),
    plotOutput(outputId = ns("scatterplot"))
  )
}

#' Scatter Plot Display Module - Server
#'
#' Handles the server-side logic for rendering a scatter plot.
#'
#' @param id *(character)* Namespace ID for the module.
#' @param var_inputs *(reactive)* A reactive expression containing 
#'  user-selected variables.
#' @param aes_inputs *(reactive)* A reactive expression containing 
#'  user-selected attributes.
#'
#' @return No direct return value. This function generates a plot output.
#'
#' @section Details: 
#' `mod_scatter_display_server()`:
#' - Uses `var_inputs` to dynamically generate a scatter plot with 
#'   user-selected variables.
#' - Reads from the `movies` dataset, which must be loaded in the app 
#'   environment.
#' - Processes plot titles and axis labels to improve readability.
#'
#' @section Reactive Inputs:
#' - `var_inputs()$x`: X-axis variable.
#' - `var_inputs()$y`: Y-axis variable.
#' - `var_inputs()$z`: Color aesthetic variable.
#' - `aes_inputs()$alpha`: Transparency level.
#' - `aes_inputs()$size`: Size of points.
#' - `aes_inputs()$plot_title`: Title of the plot.
#'
#' @seealso
#' - [`mod_var_input_server()`] for variable selection.
#' - [`mod_aes_input_server()`] for aesthetics selection.
#' - [`scatter_plot()`] for generating the scatter plot.
#'
#' @family **Plot Display Module**
#'
#' @examples
#' if (interactive()) {
#'   shiny::shinyApp(
#'     ui = shiny::fluidPage(
#'       mod_var_input_ui("vars"),
#'       mod_aes_input_ui("aes"),
#'       mod_scatter_display_ui("plot")
#'     ),
#'     server = function(input, output, session) {
#'       selected_vars <- mod_var_input_server("vars")
#'       selected_aes <- mod_var_input_server("aes")
#'       mod_scatter_display_server("plot", selected_vars, selected_aes)
#'     }
#'   )
#' }
#' 
#' @export
mod_scatter_display_server <- function(id, var_inputs, aes_inputs) {

  moduleServer(id, function(input, output, session) {

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
      
      logr_msg("Preparing scatterplot in mod_scatter_display_server", 
                level = "TRACE")
      
      tryCatch({
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

    }, error = function(e) {

      logr_msg(glue::glue("Failed to render scatterplot. Reason: {e$message}"), 
               level = "ERROR")
      
    })
      
    })
  })
}
