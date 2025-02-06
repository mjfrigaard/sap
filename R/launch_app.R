#' Launch the Movies Review Application
#'
#' Starts the Movies Review Shiny application, which provides a customizable
#' scatter plot interface for analyzing movie data.
#' 
#' @param app which app to run. Options are:
#'  * `NULL` = the default app (`"movies"`)  
#'  * `"bslib"` = alternative `bslib` layout 
#'  * `"ggp2"` = `ggplot2movies` (tidy) data app.
#'  * `"quarto"` = Quarto movies app.
#' @param options arguments to pass to `options()`
#' @param run where to launch app:
#'  * `p` = launch in viewer pane
#'  * `b` = launch in external browser
#'  * `w` = launch in window
#' @param ... arguments passed to UI 
#'
#' @return A **Shiny application** object.
#'
#' @section Details:
#' The application uses:
#' - **UI**: Defined in [`movies_ui()`].
#' - **Server Logic**: Defined in [`movies_server()`].
#'
#' @seealso
#' - [`movies_ui()`] for the user interface.
#' - [`movies_server()`] for the server logic.
#'
#' @family **Standalone Application**
#' 
#' @details
#' See the [ggplot2movies](https://github.com/hadley/ggplot2movies) package.
#' 
#'
#' @examples
#' if (interactive()) {
#'   launch_app()
#' }
#'
#' 
#' @export
#' 
#' @import shiny
#' 
launch_app <- function(app = NULL, options = list(), run = "p", ...) {
  
  if (interactive()) {
    display_type(run = run)
  }

  if (is.null(app)) {
    app <- "movies"
  }

  logr_msg(glue::glue("Launching app: {app}"),
           level = "INFO")
  
  tryCatch({
    
    if (app == "bslib") {
      shinyApp(
        ui = movies_ui(bslib = TRUE),
        server = movies_server,
        options = options
      )
    } else if (app == "ggp2") {
      shinyAppDir(
        appDir = system.file("tidy-movies", package = "sap"),
        options = options
      )
    } else if (app == "quarto") {
      quarto::quarto_preview(
        system.file("quarto", "index.qmd", package = "sap"), 
        render = "all"
      )
    } else {
      shinyApp(
        ui = movies_ui(...),
        server = movies_server,
        options = options
      )
    }
    
  }, error = function(e) {
    
    logr_msg(glue::glue("FATAL: Application failed to launch. Reason: {e$message}"), 
             level = "FATAL")
    
    stop("Application launch failed. Check logs for details.")
    
  })
  
}
