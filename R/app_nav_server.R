#' Application Navigation Server Logic
#'
#' @param input,output Shiny server input and output objects.
#'
#' @return Server logic for the Shiny application with navigation.
#' 
#' @section Modules:
#' - `scatter_values`: Values for scatter plot.
#' - `year_value`: Selected year value.
#'
#' @seealso [app_nav_ui()]
#' 
#' @export
app_nav_server <- function(input, output) {
  
  scatter_values <- mod_vars_server("scatter_inputs")

  mod_point_server(id = "scatter", vals = scatter_values)
  
  year_value <- mod_num_input_server("year")
  
  mod_vbar_server(id = "genre", vals = year_value)
  
  mod_hbar_server(id = "mpaa", vals = year_value)

  mod_tbl_server(id = "table", vals = year_value)

}