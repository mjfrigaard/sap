#' Development `ggplot2movies` app standalone function
#'
#' Wrapper function for `shinyAppDir()`
#' 
#' @param test logical, run in `test.mode`? Defaults to `FALSE`.
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
ggp2_movies_app <- function(test = FALSE, run = "w") {
  
  if (interactive()) {
      display_type(run = run)
      if (test) {
        shinyAppDir(
          appDir = system.file("dev", 
                               package = "moviesApp"),
          options(test.mode = TRUE)
        )
      } else {
        shinyAppDir(
          appDir = system.file("dev", 
                               package = "moviesApp")
        )
      }
  } else {
      shinyAppDir(
        appDir = system.file("dev", 
                             package = "moviesApp"))
  }
  
}
