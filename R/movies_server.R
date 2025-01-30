#' Handles the server-side logic for the Movies Review application.
#'
#' @param input The Shiny `input` object.
#' @param output The Shiny `output` object.
#' @param session The Shiny `session` object.
#'
#' @return Defines server logic for reactive outputs and module 
#' integration.
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
#' 
movies_server <- function(input, output, session) {
      
  logr_msg(message = "New user session started", 
           level = "INFO", log_file = "_logs/app_log.txt")

  tryCatch({
    selected_vars <- mod_var_input_server("vars")
  }, error = function(e) {
    logr_msg(glue::glue("Error in variable selection module: {e$message}"), 
           level = "ERROR", log_file = "_logs/app_log.txt")
  })

  tryCatch({
    selected_aes <- mod_aes_input_server("aes")
  }, error = function(e) {
    logr_msg(glue::glue("Error in aesthetics selection module: {e$message}"),
           level = "ERROR", log_file = "_logs/app_log.txt")
  })

  tryCatch({
    mod_scatter_display_server("plot", 
                              var_inputs = selected_vars, 
                              aes_inputs = selected_aes)
  }, error = function(e) {
    logr_msg(glue::glue("Error in scatter display: {e$message}"), 
    level = "ERROR", log_file = "_logs/app_log.txt")
  })

  logr_msg(message = "Server function execution completed", 
           level = "TRACE", log_file = "_logs/app_log.txt")
  }

