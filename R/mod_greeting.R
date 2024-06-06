#' Greeting UI Module
#'
#' @param id A unique identifier for the module.
#'
#' @return A tagList containing the UI elements for displaying the greeting
#' message.
#'
#' @description
#' This UI module creates a text output to display a greeting message.
#'
#' @details
#' This UI module works in conjunction with the `mod_greeting_server` function
#' to display a personalized greeting message based on user input.
#' 
#' @export
mod_greeting_ui <- function(id) {
  ns <- NS(id)
  tagList(
    textOutput(ns("greet"))
  )
}

#' Greeting Server Module
#'
#' @param id A unique identifier for the module.
#' @param txt A reactive expression containing the user input.
#'
#' @return None
#' @export
#'
#' @description
#' This server module observes the user input and updates the greeting message
#' accordingly.
#'
#' @details
#' This server module works in conjunction with the `mod_greeting_ui` function
#' to display a personalized greeting message. It observes the reactive 
#' expression from `mod_cust_button_server` and updates the text output 
#' accordingly.
mod_greeting_server <- function(id, txt) {
  moduleServer(id, function(input, output, session) {
    # Observe the button click
    observe({
      output$greet <- renderText({
        paste("Hello, my name is ", txt())
      })
    }) |>
      bindEvent(txt())
  })
}