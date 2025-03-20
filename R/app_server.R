#' The application server-side
#'
#' @param input,output,session Internal parameters for {shiny}.
#'     DO NOT REMOVE.
#' @import shiny
#' @noRd
app_server <- function(input, output, session) {
  # Your application server logic
  # observe({
    # browser()

      selected_vars <- mod_var_inputs_server("vars")

      selected_aes <- mod_aes_inputs_server("aes")

      mod_scatter_display_server("plot",
                                  var_inputs = selected_vars,
                                  aes_inputs = selected_aes)

  # })
}
