#' Button UI Function
#'
#' @return A tagList containing the main UI layout.
#'
#' @description
#' This function creates the main UI layout of the Shiny app.
#'
#' @details
#' The main UI layout includes the customer button module for user input and 
#' the greeting module for displaying the greeting message. It also includes an
#' output to display reactive values for debugging purposes.
#' 
#' @export
#' 
buttonUI <- function() {
  tagList(
    page_fillable(
      layout_sidebar(
        sidebar = sidebar(
          mod_cust_button_ui(id = "click")
        ),
        card(
          mod_greeting_ui(id = "greeting")
        ),
        card(
          verbatimTextOutput(outputId = "vals")
        )
      )
    )
  )
}