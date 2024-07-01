#' Movies app standalone function
#'
#' Wrapper function for `shinyApp()`
#'
#' @param options arguments to pass to `options()`
#' @param ... arguments passed to UI
#' @param ... additional arguments passed to UI
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
launch_app <- function(options = list(), run = "p", ...) {
  if (interactive()) {
    display_type(run = run)
  }
    shinyApp(
      ui = movies_ui(...),
      server = movies_server,
      options = options
    )
}
