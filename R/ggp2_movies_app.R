#' Development `ggplot2movies` app standalone function
#'
#' Wrapper function for `shinyAppDir()`
#' 
#' @param test logical, run in `test.mode`? Defaults to `TRUE`.
#' 
#' @return shiny app
#' 
#'
#' @export
ggp2_movies_app <- function(test = TRUE, run = "w") {
  if (interactive()) {
    display_type(run = run)

    if (isTRUE(test)) {
      shinyAppDir(
        appDir = system.file("dev",
          package = "moviesApp"
        ),
        options(test.mode = TRUE)
      )
    } else {
      shinyAppDir(
        appDir = system.file("dev",
          package = "moviesApp"
        ),
        options(test.mode = FALSE)
      )
    }
  } else {
    shinyAppDir(appDir = system.file("dev",
      package = "moviesApp"
    ))
  }
}
