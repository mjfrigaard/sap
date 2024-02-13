#' Movies server function
#' 
#' Server function for standalone app function 
#' 
#' @usage NULL
#' 
#' @details
#' The [movies_app()] function is as a wrapper for `shinyApp()`: 
#' 
#' ```
#' shinyApp(movies_ui, movies_server)
#' ```
#' 
#' In [movies_app()]:
#'  * UI is stored in [movies_ui()]   
#'  * server is stored in `movies_server()`
#'  
#' @section `var_input` module: 
#' [mod_var_input_server()] returns following reactive values:
#'  * `x`
#'  * `y`
#'  * `z`
#'  * `alpha`
#'  * `size`
#'  * `plot_title`
#' 
#' @seealso [mod_var_input_ui()]
#' 
#' @section `scatter_display` module: 
#' [mod_scatter_display_server()] displays the `ggplot2` graph with the 
#' [scatter_plot()] function.
#' 
#' @seealso [mod_scatter_display_ui()]
#' 
#' @section Communication: 
#' The output from [mod_var_input_server()] should be supplied to the 
#' `var_inputs` argument of [mod_scatter_display_server()].
#
#' @return `server` argument in `shinyApp()`
#' 
#' @export
#' 
movies_server <- function(input, output, session) {
  
      # create reactive values
      rVals <- reactiveValues()

      # assign inputs to rVals
      rVals$inputs <- mod_var_input_server("vars", .dev = TRUE)
      
      # view output in the UI
      output$vals <- renderPrint({
        rVals$inputs()
      })
      
      # pass reactive values to display
      mod_scatter_display_server("plot", rVals = rVals, .dev = TRUE)
      
}
