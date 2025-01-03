#' Movies app standalone function
#'
#' Wrapper function for `shinyApp()`
#'
#' @param app which app to run. Options are: 
#'  * `"movies"` = the default app  
#'  * `"bslib"` = alternative `bslib` layout
#'  * `"ggp2"` = tidy version of `ggplot2movies::movies` data 
#'  * `"quarto"` = quarto version of movies app
#' @param options arguments to pass to `options()`
#' @param run where to launch app:
#'  * `p` = launch in viewer pane
#'  * `b` = launch in external browser
#'  * `w` = launch in window
#' @param ... arguments passed to UI
#'
#' @return shiny app
#'
#' @seealso [mod_var_input_ui()], [mod_var_input_server()], [mod_scatter_display_ui()], [mod_scatter_display_server()]
#'
#' @import shiny
#'
#' @export launch_app
#'
launch_app <- function(app = "movies", options = list(), run = "p", ...) {
  if (interactive()) {
    display_type(run = run)
  }
  if (app == "bslib") {
    shinyApp(
      ui = movies_ui(bslib = TRUE),
      server = movies_server,
      options = options
    )
  } else if (app == "ggp2") {
      shinyAppDir(
        appDir = system.file("tidy-movies",
          package = "sap"
      ),
      options = options
      )
  } else if (app == "quarto") {
      quarto::quarto_preview(
        system.file("quarto", "index.qmd",
            package = "sap" ), 
        render = "all")
  } else {
    shinyApp(
      ui = movies_ui(...),
      server = movies_server,
      options = options
    )
  }
}