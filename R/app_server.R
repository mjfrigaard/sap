#' Application Server
#'
#' @param input Shiny input
#' @param output Shiny output
#' @param session Shiny session
#' @return None
app_server <- function(input, output, session) {
  # Load and prepare data
  movies_data <- reactive({
    sap::movies
  })

  # Get inputs from centralized inputs module
  inputs <- mod_inputs_server("inputs")

  # Call visualization module with inputs
  viz_results <- mod_visualization_server("viz", movies_data, inputs)

  # Call data table module with inputs
  table_results <- mod_data_table_server("table", movies_data, inputs)

  # Call download report module with inputs
  mod_download_report_server("download", viz_results, table_results, inputs)
}