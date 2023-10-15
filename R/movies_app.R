#' Movies app standalone function
#'
#' Wrapper function for `runApp()`
#' 
#' @param test logical, run in `test.mode`?
#' @param run where to launch app: 
#'  * `p` = launch in viewer pane
#'  * `b` = launch in external browser  
#'  * `w` = launch in window
#'  * `NULL` = `getOption(x = 'shiny.launch.browser')`
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
movies_app <- function(test = FALSE, run = "w") {
  
  display_type(run = run)
    
    if (test) {
      shinyApp(
        ui = movies_ui,
        server = movies_server,
        options = list(test.mode = TRUE)
      )
    } else {
      shinyApp(
        ui = movies_ui,
        server = movies_server, 
        options = list(test.mode = FALSE)
      )
    }
}
