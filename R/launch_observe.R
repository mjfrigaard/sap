#' Launch a Simple Shiny App Demonstrating `observe()`
#'
#' The `launch_observe()` function launches a Shiny application that demonstrates
#' the use of the `observe()` function within a server environment. The app 
#' contains a single button that triggers a console message when clicked.
#'
#' @details
#' This app creates a minimal UI with a single button labeled "Click Me!". 
#' When the button is clicked, the `observe()` function in the server logic 
#' detects the click event and prints "Clicked!" to the R console. 
#'
#' @examples
#' if (interactive()) {
#'   launch_observe()
#' }
#'
#'
#' 
#' @export
launch_observe <- function() {
  ui <- bslib::page_fluid(
    h4("Simple observe() Shiny App"),
    bslib::layout_column_wrap(
      width = 1/2,
      bslib::card(
        bslib::card_header("Press the Button"),
        actionButton(
          inputId = "btn", 
          label = "Click Me!")
      )
    )
  )
  server <- function(input, output, session) {
    observe({
      if (input$btn > 0) {  
        print("Clicked!")  
      }
    })
  }
  shinyApp(ui, server)
}
