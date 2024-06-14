#' User Interface for Numeric Input
#'
#' @param id Shiny module ID.
#'
#' @return A UI for selecting a numeric input.
#' 
#' @section Inputs:
#' - `year`: Theater release year.
#'
#' @seealso [mod_num_input_server()]
#' 
#' @export
#' 
mod_num_input_ui <- function(id) {
  ns <- NS(id)
    tagList(
        markdown("**Theater Release Year**"),
        numericInput(
        inputId = ns("start_year"),
        label = "Start",
        value = 1980,
        min = min(movies[["thtr_rel_year"]]),
        max = max(movies[["thtr_rel_year"]]),
        step = 1
      ),
        numericInput(
        inputId = ns("end_year"),
        label = "End",
        value = 1990,
        min = min(movies[["thtr_rel_year"]]),
        max = max(movies[["thtr_rel_year"]]),
        step = 1
      )
    )
}

#' Server Logic for Numeric Input
#'
#' @param id Shiny module ID.
#'
#' @return A reactive list containing the selected year.
#' 
#' @section Reactive Values:
#' - `start_year`: Selected start theater release year.
#' - `end_year`: Selected end theater release year.
#'
#' @seealso [mod_num_input_ui()]
#' 
#' @export
#' 
mod_num_input_server <- function(id) {
  moduleServer(id, function(input, output, session) {
    
    observe({
      if (input$start_year >= input$end_year) {
        updateNumericInput(
          session = session, 
          inputId = "end_year", 
          value = input$start_year + 1)
      }
    }) |> 
      bindEvent(input$start_year)
    
    observe({
      if (input$end_year <= input$start_year) {
        updateNumericInput(
          session = session, 
          inputId = "start_year", 
          value = input$end_year - 1)
      }
    }) |> 
      bindEvent(input$end_year)
    
    return(
      reactive({
        list(
          "start_year" = input$start_year,
          "end_year" = input$end_year
        )
      })
    )
  })
}