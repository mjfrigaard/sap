#' Button App
#' 
#' @return None
#'
#' @description
#' Standalone app function
#' 
#' @export
buttonApp <- function() {
  shinyApp(ui = buttonUI, server = buttonServer)
}
