#' User Interface for Counts Text
#'
#' @param id Shiny module ID.
#'
#' @return A UI for displaying a the time span.
#'
#' @section Outputs:
#' - `counts_text`: text output.
#'
#' @seealso [mod_counts_txt_server()]
#'
#' @export
mod_counts_txt_ui <- function(id) {
  ns <- NS(id)
  tagList(
    uiOutput(outputId = ns("counts_text"))
    # verbatimTextOutput(outputId = ns("counts_text"))
  )
}

#' Server Logic for Counts Text
#'
#' @param id Shiny module ID.
#' @param vals Reactive list of table parameters.
#'
#' @return Renders a data table based on selected parameters.
#'
#' @section Reactive Inputs:
#' - `vals`: Reactive list of table parameters.
#'
#' @seealso [mod_counts_txt_ui()]
#'
#' @export
mod_counts_txt_server <- function(id, vals) {
  moduleServer(id, function(input, output, session) {
    
    output$counts_text <- renderUI({
      req(vals())
      tspan <- abs(vals()$start_year - vals()$end_year)
      tsan_text <- paste("Time span =", tspan, "years")
      h3(tsan_text)
    })
    
  })
}
