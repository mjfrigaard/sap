#' Movies app standalone function
#'
#' Wrapper function for `shiny::shinyApp()`
#'
#' @return shiny app
#' 
#' 
#' @seealso [mod_var_input_ui()], [mod_var_input_server()], [mod_scatter_display_ui()], [mod_scatter_display_server()]
#'
movies_app <- function() {
  shiny::shinyApp(ui = movies_ui, server = movies_server)
}