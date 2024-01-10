#' Shiny app display mode helper
#'
#' @param run where to launch app:
#'  * `"p"` = launch in viewer pane
#'  * `"b"` = launch in external browser
#'  * `"w"` = launch in window (default)
#'
#' @return notification of `shinyViewerType` option
#'
#' @export display_type
#'
display_type <- function(run = "w") {
  
  if (run == "p") {
    
    options(shiny.launch.browser = .rs.invokeShinyPaneViewer)
    
  } else if (run == "b") {
    
    options(shiny.launch.browser = .rs.invokeShinyWindowExternal)
    
  } else if (run == "w") {
    
    options(shiny.launch.browser = .rs.invokeShinyWindowViewer)
    
  } else {
    
    options(shiny.launch.browser = NULL)
    
  }
  
  shinyViewerType <- getOption("shiny.launch.browser") |>
    attributes() |>
    unlist() |>
    unname()
  
  cli::cli_alert_info("shinyViewerType set to {shinyViewerType}")
  
}
