#' Application Navigation Server Logic
#'
#' @param input,output Shiny server input and output objects.
#'
#' @return Server logic for the Shiny application with navigation.
#' 
#' @section Modules:
#' - `scatter_values`: Values for scatter plot.
#' - `count_values`: Selected year value.
#'
#' @seealso [navbar_ui()]
#' 
#' @export
navbar_server <- function(input, output) {
  
  # scatter plot values 
  scatter_values <- mod_point_vars_server("scatter_inputs")
  mod_point_server(id = "scatter", vals = scatter_values)
  
  # count values 
  count_values <- mod_count_vars_server("year")
  mod_counts_txt_server("cnt_txt", count_values)
  mod_hbar_server(id = "hbar", vals = count_values)
  mod_waffle_server(id = "waffle", vals = count_values)
  mod_counts_tbl_server(id = "cnt_tbl", vals = count_values)
  
  # distribution values 
  dist_values <- mod_dist_vars_server("dist")
  mod_raincloud_server("cloud", vals = dist_values)
  mod_boxplot_server("box", vals = dist_values)
  mod_dist_tbl_server("dist_tbl", vals = dist_values)
  
  # awards values 
  award_values <- mod_awards_vars_server("awards_vars")
  mod_point_text_server("awards_plot", award_values)
  mod_awards_tbl_server("awards_table", award_values)
  
}
