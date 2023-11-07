#' The application server-side
#'
#' @param input,output,session Internal parameters for {shiny}.
#'     DO NOT REMOVE.
#'
#'
#' @keywords internal
app_server <- function(input, output, session) {
  # Your application server logic
   selected_vars <- mod_var_input_server("vars")
   
   mod_scatter_display_server("plot", var_inputs = selected_vars)
}
