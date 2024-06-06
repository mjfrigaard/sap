#' Button Server Function
#'
#' @param input Shiny input object.
#' @param output Shiny output object.
#' @param session Shiny session object.
#'
#' @return None
#'
#' @description
#' This function defines the server logic of the Shiny app.
#'
#' @details
#' The main server logic includes the customer button server module to capture
#' user input and the greeting server module to display the personalized 
#' greeting message. It also includes an output to display reactive values for
#' debugging purposes.
#' 
#' @export
#' 
buttonServer <- function(input, output, session) {
  
  txt <- mod_cust_button_server(id = "click")

  mod_greeting_server(id = "greeting", txt = txt)

  output$vals <- renderPrint({
    x <- reactiveValuesToList(x = input, all.names = TRUE)
    print(x)
  })
  
}