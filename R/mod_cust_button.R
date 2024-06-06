#' Customer Button UI Module
#'
#' @param id A unique identifier for the module.
#'
#' @return A tagList containing the UI elements for the customer button module.
#'
#' @description
#' This UI module creates a simple form with a text input for the user to enter
#' their name and a submit button.
#'
#' @details
#' This UI module works in conjunction with the `mod_cust_button_server` 
#' function to handle user input. The input value is captured and can be used
#' in other server modules.
#' 
#' @export
#' 
mod_cust_button_ui <- function(id) {
  ns <- NS(id)
  tagList(
    tags$form(
      tags$label("Enter your name:"),
      tags$input(
        type = "text",
        id = ns("name_input"),
        name = "name"
      ),
      tags$input(
        type = "submit",
        id = ns("button_click"),
        value = "Click me!"
      )
    )
  )
}

#' Customer Button Server Module
#'
#' @param id A unique identifier for the module.
#'
#' @return A reactive expression containing the user input from the text field.
#'
#' @description
#' This server module captures the user input from the text field and makes it 
#' available as a reactive expression.
#'
#' @details
#' This server module works in conjunction with the `mod_cust_button_ui` 
#' function to capture user input. The reactive expression returned by this
#' module can be used by other modules to access the input value.
#' 
#' @export
#' 
mod_cust_button_server <- function(id) {
  moduleServer(id, function(input, output, session) {
    return(
      reactive({
        input$name_input
      })
    )
  })
}