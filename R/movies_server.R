#' Server Logic for the Movies Review Application
#'
#' Handles the server-side logic for the Movies Review application.
#'
#' @param input The Shiny `input` object.
#' @param output The Shiny `output` object.
#' @param session The Shiny `session` object.
#'
#' @return Defines server logic for reactive outputs 
#' and module integration.
#'
#' @section Details:
#' The server integrates the following modules:
#' - **Variable Input Module**: Processes user input for scatter plot 
#'   customization using  [`mod_var_input_server()`].
#' - **Plot Display Module**: Generates and displays a scatter plot 
#'   based on user inputs using [`mod_scatter_display_server()`].
#'
#' @seealso
#' - [`movies_ui()`] for the corresponding user interface.
#' - [`launch_app()`] for the entry point of the application.
#'
#' @family **Application Components**
#'
#' @examples
#' if (interactive()) {
#'   shiny::shinyApp(ui = movies_ui(), server = movies_server)
#' }
#' 
#' @export
movies_server <- function(input, output, session) {

      selected_vars <- mod_var_input_server("vars")

      mod_scatter_display_server("plot", var_inputs = selected_vars)
      
}
