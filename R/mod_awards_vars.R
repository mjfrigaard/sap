#' UI for awards variables module
#'
#' Creates inputs for selecting award types and filtering by theater release
#' years. This function is designed to work together with 
#' [mod_awards_vars_server()].
#'
#' @param id A character string used to identify the namespace for the module.
#'
#' @return A `tagList` containing UI elements:
#'   * A select input for award type (Films or Stars)
#'   * Two numeric inputs for selecting the start and end years for theater
#'     release filtering
#'
#' @seealso [mod_awards_vars_server()] for the server-side logic
#'
#' @examples
#' # UI implementation
#' ui <- fluidPage(
#'   mod_awards_vars_ui("awards1")
#' )
#'
#' # Server implementation
#' server <- function(input, output, session) {
#'   award_vars <- mod_awards_vars_server("awards1")
#' }
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

#' @title Server Logic for Count Tab Input
#' 
#' @description
#' Processes and validates user inputs for the awards section, ensuring 
#' start and end years are properly sequenced. Provides the selected
#' year range and award type to other components.
#'
#' @param id Shiny module ID.
#'
#' @return A reactive list containing the selected years and award type.
#' 
#' @seealso [mod_awards_vars_ui()] The corresponding UI function.
#' 
#' @export
#' 
mod_awards_vars_server <- function(id) {
  moduleServer(id, function(input, output, session) {
    
    # Track initialization to avoid unnecessary log messages
    initialized <- reactiveVal(FALSE)
    
    # Log module startup
    logr_msg("Initializing awards variables module", level = "INFO")
    
    observe({
      if (input$start_year >= input$end_year) {
        logr_msg(glue::glue("Adjusting end_year from {input$end_year} to ",
        "{input$start_year + 1}"), level = "DEBUG")
        
        updateNumericInput(
          session = session, 
          inputId = "end_year", 
          value = input$start_year + 1)
        }
      }) |> 
      bindEvent(input$start_year)
      
      observe({
        if (input$end_year <= input$start_year) {
          logr_msg(glue::glue("Adjusting start_year from {input$start_year} to ",
          "{input$end_year - 1}"), level = "DEBUG")
          
          updateNumericInput(
            session = session, 
            inputId = "start_year", 
            value = input$end_year - 1)
          }
        }) |> 
        bindEvent(input$end_year)
        
        # Monitor all inputs for logging purposes
        observe({
          if (initialized()) {
            logr_msg(glue::glue("Awards criteria updated: {input$award}, years ",
            "{input$start_year}-{input$end_year}"), 
            level = "INFO")
          } else {
            initialized(TRUE)
          }
        }) |>
        bindEvent(input$start_year, input$end_year, input$award)
        
        return(
          reactive({
            valid_years <- req({nchar(input$start_year) == 4 & 
              nchar(input$end_year) == 4})
              
              if (!valid_years) {
                logr_msg("Invalid year format detected in awards module", 
                level = "WARN")
              }
              
              logr_msg(glue::glue("Returning awards selection: {input$award}, years ",
              "{input$start_year}-{input$end_year}"), 
              level = "TRACE")
              
              list(
                "start_year" = input$start_year,
                "end_year" = input$end_year,
                "award" = input$award
              )
            })
          )
        })
}