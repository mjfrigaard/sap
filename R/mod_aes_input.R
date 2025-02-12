#' Aesthetics Input Module - UI
#'
#' Creates a UI for selecting attributes for a scatter plot.
#'
#' @param id *(character)* Namespace ID for the module.
#'
#' @return A `shiny::tagList()` containing UI elements for variable 
#' selection.
#'
#' @section Details: 
#' `mod_aes_input_ui()` provides UI controls for customizing scatter plots. 
#'  It includes:  
#' - **Sliders**:
#'   - Transparency (`alpha`) ranging from 0 to 1.
#'   - Point size ranging from 0 to 5.
#' - **Text Input**:
#'   - Plot title.
#'
#' The function uses `shiny::NS()` to namespace all input IDs.
#'
#' @seealso
#' - [`mod_aes_input_server()`]  for server-side logic.
#' - [`shiny::tagList()`](https://shiny.rstudio.com/reference/shiny/latest/tagList.html) 
#'   for containing UI elements.
#' - [`shiny::NS()`](https://shiny.rstudio.com/reference/shiny/latest/NS.html) 
#'   for namespacing.
#'
#' @family **Aesthetics Input Module**
#'
#' @examples
#'
#' if (interactive()) {
#'   shiny::shinyApp(
#'     ui = shiny::fluidPage(mod_aes_input_ui("aes")),
#'     server = function(input, output, session) {
#'       selected_vars <- mod_aes_input_server("aes")
#'       shiny::observe(
#'           print(selected_vars())
#'        )
#'     }
#'   )
#' }
#' 
#' 
#' @export
mod_aes_input_ui <- function(id) {
  ns <- NS(id)
  tagList(
    strong(
      code("aes_input"),
      "module reactive ",
      code("inputs")
      ),
    verbatimTextOutput(ns("vals")),
    sliderInput(
      inputId = ns("alpha"),
      label = "Alpha:",
      min = 0, max = 1, step = 0.1,
      value = 0.5
    ),
    sliderInput(
      inputId = ns("size"),
      label = "Size:",
      min = 0, max = 5,
      value = 2
    ),
    textInput(
      inputId = ns("plot_title"),
      label = "Plot title",
      placeholder = "Enter plot title"
    )
  )
}

#' Aesthetics Input Module - Server
#'
#' Handles the server-side logic for the variable input module.
#'
#' @param id *(character)* Namespace ID for the module.
#'
#' @return A **reactive expression** that returns a list of selected input
#'   values:  
#' - `alpha`: Transparency level of points (0-1).
#' - `size`: Size of the points.
#' - `plot_title`: Title for the scatter plot.
#'
#' @section Details: 
#' `mod_aes_input_server()` reads user input from the corresponding UI 
#'  function created with `mod_aes_input_ui()`. It processes and returns a reactive object 
#'  containing the selected plot attributes.
#'
#' @seealso
#' - [`mod_aes_input_ui()`] for the UI counterpart of this module.
#' - [`mod_scatter_display_server()`] for displaying the scatter plot.
#'
#' @family **Aesthetics Input Module**
#'
#' if (interactive()) {
#'   shiny::shinyApp(
#'     ui = shiny::fluidPage(mod_var_input_ui("vars")),
#'     server = function(input, output, session) {
#'       selected_vars <- mod_var_input_server("vars")
#'       shiny::observe(print(selected_vars()))
#'     }
#'   )
#' }
#'
#' 
#' @export
mod_aes_input_server <- function(id) {
  moduleServer(id, function(input, output, session) {

    observe({
      # use shiny to validate input and log warnings/errors
      validate(
        need(try(input$alpha >= 0 & input$alpha <= 1), 
              "Alpha must be between 0 and 1")
      )
      if (input$alpha < 0 || input$alpha > 1) {
        logr_msg(message = "Alpha value out of range: {alpha}", 
        level = "WARN")
      }
      validate(
        need(try(input$size > 0), 
              "Size must be positive")
      )
      if (input$size <= 0) {
        logr_msg(message = "Invalid size value: {size}", 
        level = "ERROR")
      }
    }) |> bindEvent(c(input$alpha, input$size))

    return(
      reactive({
        list(
          "alpha" = input$alpha,
          "size" = input$size,
          "plot_title" = input$plot_title
        )
      })
    )
  })
}
