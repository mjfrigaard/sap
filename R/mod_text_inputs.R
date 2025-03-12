#' text input shiny module (UI)
#'
#' @param id shiny module id
#'
#' @export
#' 
mod_text_input_ui <- function(id) {
  ns <- shiny::NS(id)
  shiny::tagList(
    textInput(
      inputId = ns("director"),
      label = "Director name contains (e.g., Miyazaki)"),
    textInput(
      inputId = ns("cast"),
      label = "Cast names contains (e.g. Tom Hanks)")
    )
}
#' text input shiny module (server)
#'
#' @param id shiny module id
#'
#' @export
#' 
mod_text_input_server <- function(id) {
  shiny::moduleServer(id, function(input, output, session) {
    ns <- session$ns
      return(
        reactive(
          list(
          'director' = input$director,
          'cast' = input$cast
          )
        )
      )
  })
}

