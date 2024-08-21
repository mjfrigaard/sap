#' User Interface for Awards Tab Input
#'
#' @param id Shiny module ID.
#'
#' @return A UI for selecting a numeric input.
#' 
#' @section Inputs:
#' - `start_year`: Selected 'Theater Release' start year.
#' - `end_year`: Selected 'Theater Release' end year.
#'
#' @seealso [mod_awards_vars_server()]
#' 
#' @export
#' 
mod_awards_vars_ui <- function(id) {
  ns <- NS(id)
    tagList(
      markdown("**Theater Release Year**"),
      selectInput(ns("award"), 
        label = "Award Type", 
        choices = c("Films", "Stars"), 
        selected = "Films"),
        markdown("**Theater Release Year**"),
      numericInput(
        inputId = ns("start_year"),
        label = "Start",
        value = 1984,
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

#' Server Logic for Count Tab Input
#'
#' @param id Shiny module ID.
#'
#' @return A reactive list containing the selected year.
#' 
#' @section Reactive Values:
#' - `award`: Selected award variable (`Films` or `Stars`)
#' - `start_year`: Selected 'Theater Release' start year.
#' - `end_year`: Selected 'Theater Release' end year.
#'
#' @seealso [mod_awards_vars_ui()]
#' 
#' @export
#' 
mod_awards_vars_server <- function(id) {
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
        req({nchar(input$start_year) == 4 & 
             nchar(input$end_year) == 4})
        list(
          "start_year" = input$start_year,
          "end_year" = input$end_year,
          "award" = input$award
        )
      })
    )
  })
}
