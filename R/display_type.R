#' Shiny app display mode helper
#'
#' @param run where to launch app: 
#'  * `"p"` = launch in viewer pane 
#'  * `"b"` = launch in external browser  
#'  * `"w"` = launch in window (default)
#'
#' @return notification of `shinyViewerType` option
#' 
#' @export
#'
display_type <- function(run = "w") {
  if (Sys.getenv("RSTUDIO") != "1") {
    environment <- "RStudio"
    cli::cli_alert_info("App not running in {environment}")
  } else {
    switch(run,
      p = options(shiny.launch.browser = .rs.invokeShinyPaneViewer),
      b = options(shiny.launch.browser = .rs.invokeShinyWindowExternal),
      w = options(shiny.launch.browser = .rs.invokeShinyWindowViewer),
      NULL = options(shiny.launch.browser = NULL))
    environment <- "RStudio"
    shinyViewerType <- getOption('shiny.launch.browser') |> 
                        attributes() |> 
                        unlist() |> 
                        unname()
                      
    cli::cli_alert_info("App running in {environment}")
    cli::cli_alert_info("shinyViewerType set to {shinyViewerType}")
  }
  
}
