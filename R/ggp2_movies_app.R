#' Development `ggplot2movies` app standalone function
#'
#' Wrapper function for `shinyAppDir()`
#'
#' @param options arguments to pass to `options()`
#' @param run where to launch app:
#'  * `p` = launch in viewer pane
#'  * `b` = launch in external browser
#'  * `w` = launch in window
#'  * `NULL` = `getOption(x = 'shiny.launch.browser')`
#'
#' @return shiny app
#'
#'
#' @export
ggp2_movies_app <- function(options = list(), run = "w", ...) {
  if (interactive()) {
    display_type(run = run)
  } 
    shinyAppDir(
    appDir = system.file("dev",
      package = "shinyrPkgs"
    ),
    options = options
  )
}
