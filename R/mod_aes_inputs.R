#' aes_inputs UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList
mod_aes_inputs_ui <- function(id) {
  ns <- NS(id)
  tagList(
    sliderInput(
      inputId = ns("alpha"),
      label = "Alpha:",
      min = 0, max = 1, step = 0.1,
      value = 0.7
    ),
    sliderInput(
      inputId = ns("size"),
      label = "Size:",
      min = 0, max = 5,
      value = 3
    ),
    textInput(
      inputId = ns("plot_title"),
      label = "Plot title",
      placeholder = "Enter plot title"
    )
  )
}

#' aes_inputs Server Functions
#'
#' @noRd
mod_aes_inputs_server <- function(id){
  moduleServer(id, function(input, output, session){
    ns <- session$ns
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

## To be copied in the UI
# mod_aes_inputs_ui("aes_inputs_1")

## To be copied in the server
# mod_aes_inputs_server("aes_inputs_1")
