#' Movies app standalone function
#'
#' Wrapper function for `shinyApp()`
#'
#' @return shiny app
#' 
#' 
#' @seealso [mod_var_input_ui()], [mod_var_input_server()], [mod_scatter_display_ui()], [mod_scatter_display_server()]
#' 
#' @import shiny
#'
#' @export
#' 
movies_app <- function() {
  shinyApp(ui = movies_ui, server = movies_server)
}
