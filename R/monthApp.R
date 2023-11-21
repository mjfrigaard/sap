#' Month App Package Standalone App Function 
#'
#' @param ... arguments passed to `shinyApp()`
#'
#' @return a shiny application object
#' 
#' @import shiny
#' 
#' @export
#'
monthApp <- function(...) {
  
  months <- c(
    "January", "February", "March", "April", "May", "June",
    "July", "August", "September", "October", "November", "December"
  )
  
  ui <- navbarPage(
    "Sample app",
    tabPanel("Pick a month",
      selectInput("month", "What's your favourite month?", choices = months)
    ),
    tabPanel("Feedback", 
      monthFeedbackUI(id = "tab1")),
    tabPanel("Birthstone", 
      birthstoneUI(id = "tab2"))
  )
  server <- function(input, output, session) {
    
    monthFeedbackServer(id = "tab1", reactive(input$month))
    
    birthstoneServer(id = "tab2", reactive(input$month))
    
  }
  shinyApp(ui, server, ...)
}