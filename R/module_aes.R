#' aes UI
#'
#' @param id Unique id for module instance.
#'
#' @keywords internal
aesUI <- function(id){
    ns <- NS(id)
    tagList(
    sliderInput(
      inputId = ns("alpha"),
      label = "Alpha:",
      min = 0,
      max = 1,
      step = 0.1,
      value = 0.7
    ),
    sliderInput(
      inputId = ns("size"),
      label = "Size:",
      min = 0,
      max = 5,
      step = 0.5,
      value = 3
    ),
    textInput(
      inputId = ns("plot_title"),
      label = "Plot title",
      placeholder = "Enter plot title"
    )
    )
}

#' aes Server
#'
#' @param id Unique id for module instance.
#'
#' @keywords internal
aes_server <- function(id){
    moduleServer(
        id,
        function(
            input,
            output,
            session
            ){

                ns <- session$ns
                send_message <- make_send_message(session)

      return(
        reactive({
          list(
            "alpha" = input$alpha,
            "size" = input$size,
            "plot_title" = input$plot_title
          )
        })
      )
        }
    )
}

# UI
# aesUI('id')

# server
# aes_server('id')
