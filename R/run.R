#' Run
#'
#' Run application
#'
#' @param ... Additional parameters to pass to [shinyApp].
#'
#' @import shiny
#'
#' @export
run <- function(...){
	shinyApp(
		ui = ui,
		server = server,
		...
	)
}

#' Run Development
#'
#' Runs the development version which includes
#' the build step.
#'
#' @keywords internal
#' @noRd
run_dev <- function() {
	file <- system.file("run/app.R", package = "lap")
	shinyAppFile(file)
}
