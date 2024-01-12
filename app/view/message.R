# app/view/message.R

box::use(
  shiny[actionButton, div, moduleServer, NS, renderText, req, textOutput],
)

#' @export
ui <- function(id) {
  ns <- NS(id)

  div(
    class = "message",
    actionButton(
      ns("show_message"),
      "Show message"
    ),
    textOutput(ns("message_text"))
  )
}

#' @export
server <- function(id) {
  moduleServer(id, function(input, output, session) {
    output$message_text <- renderText({
      req(input$show_message)
      "This is a message"
    })
  })
}