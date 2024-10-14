#' Launch a Debugging Shiny App
#'
#' This function launches a Shiny app that demonstrates the use of
#' `observe()`, `isolate()`, `reactive()`, and `bindEvent()` functions
#' in a simple interactive setting. The app allows users to see the behavior
#' of these reactive constructs in action, particularly how `observe()` can be
#' used with `isolate()` to control reactive dependencies and how `bindEvent()`
#' triggers specific actions.
#'
#' @details
#' The app consists of a sidebar with an action button and a numeric input
#' field. The main panel displays two outputs: one showing the isolated value
#' of the numeric input when the button is clicked, and another displaying the
#' reactive value that updates automatically as the input changes. Key reactive
#' functions used in the app include:
#'
#' - `reactive()`: Creates a reactive expression that updates whenever the
#'    numeric input changes.
#' - `observe()`: Monitors events and performs actions, here used with
#'    `bindEvent()` to execute code when the button is clicked.
#' - `isolate()`: Prevents reactive dependencies within `observe()`, ensuring
#'    the value is only updated when the button is pressed, not when the input
#'    changes directly.
#' - `bindEvent()`: Binds an event (button click) to the execution of a specific
#'    code block.
#'
#'
#' @return
#' Launches the Shiny app in the default web browser.
#'
#' @examples
#' if (interactive()) {
#'   launch_debug()
#' }
#'
#' @export
#'
launch_debug <- function() {
  ui <- bslib::page_fluid(
    titlePanel("Debug App"),
    bslib::layout_sidebar(
      sidebar = bslib::sidebar(
        actionButton("trigger", "Click Me!"),
        numericInput("input_num", "Enter a number:", value = 1)
      ),
      bslib::card(
        uiOutput("output_value"),
        uiOutput("reactive_value"),
        uiOutput("button_value")
      )
    )
  )

  server <- function(input, output, session) {
    react_value <- reactive({
      input$input_num
    })

    observe({
      iso_value <- isolate(input$input_num)
      output$button_value <- renderUI({
        paste("Button clicked! The isolated value is:", iso_value)
      })
    }) |>
      bindEvent(input$trigger)

    output$output_value <- renderUI({
      markdown(
        paste("Isolated value from ", "`observe()`", ":", isolate(input$input_num))
      )
    })

    output$reactive_value <- renderUI({
      paste("Reactive value:", react_value())
    })
  }
  shinyApp(ui = ui, server = server)
}
