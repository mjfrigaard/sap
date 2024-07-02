#' Movies server function
#' 
#' Server function for standalone app function 
#' 
#' @usage NULL
#' 
#' @details
#' The [launch_app()] function is as a wrapper for `shinyApp()`: 
#' 
#' ```
#' shinyApp(movies_ui, movies_server)
#' ```
#' 
#' In [launch_app()]:
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
#' [mod_scatter_display_server()] displays the `ggplot2` graph with the [scatter_plot()] function.
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

      selected_vars <- mod_var_input_server("vars")

      mod_scatter_display_server("plot", var_inputs = selected_vars)
      
}
