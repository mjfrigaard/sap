# app/view/aes_inputs.R

# define module functions

#' aesthetic input values ui
#' @export
ui <- function(id) {
  box::use(
    shiny[
      NS, tagList, sliderInput, textInput
    ],
  )
  ns <- NS(id)
  tagList(
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

#' aesthetic input values server
#' @export
server <- function(id) {
  box::use(
    shiny[moduleServer, reactive],
  )

  moduleServer(id, function(input, output, session) {
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
