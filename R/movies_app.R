#' Movies app standalone function
#'
#' Wrapper function for `shinyApp()`
#'
#' @param options arguments to pass to `options()`
#' @param run where to launch app:
#'  * `p` = launch in viewer pane
#'  * `b` = launch in external browser
#'  * `w` = launch in window
#'
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
movies_app <- function(options = list(), run = "w") {
  if (interactive()) {
    display_type(run = run)
    shinyApp(
      ui = movies_ui(),
      server = movies_server,
      options = options
    )
  } else {
    # App deployed
    shinyApp(
      ui = movies_ui(),
      server = movies_server,
      options = options
    )
  }
}