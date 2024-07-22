#' Shiny app display mode helper
#'
#' @param run where to launch app: 
#'  * `"p"` = launch in viewer pane 
#'  * `"b"` = launch in external browser  
#'  * `"w"` = launch in window (default)
#' 
#' @section IDE detection: 
#' The function will check if the application is being run in RStudio 
#' (with `Sys.getenv()`) and only apply the `shiny.launch.browser` 
#' option if `TRUE`.
#'
#' @return notification of `shinyViewerType` option
#' 
#' @export
#'
display_type <- function(run = "w") {
  if (Sys.getenv("RSTUDIO") == "1") {
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
                      
    cli::cli_alert_info("Running app in {environment}")
    cli::cli_alert_info("shinyViewerType set to {shinyViewerType}")
  } else {
    environment <- "RStudio"
    cli::cli_alert_info("App is not running in {environment}")
  }
}