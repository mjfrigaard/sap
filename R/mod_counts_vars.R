#' UI for count variables module
#'
#' Creates inputs for selecting a grouping variable and defining a time range for
#' theater release years. This function is designed to work together with 
#' [mod_counts_vars_server()].
#'
#' @param id A character string used to identify the namespace for the module.
#'
#' @return A `tagList` containing UI elements:
#'   * A variable select input for choosing a grouping variable from character 
#'     columns in the movies dataset
#'   * A heading for the theater release year section
#'   * Two numeric inputs to define the start and end years for filtering movies
#'     by their theater release date
#'
#' @details
#' The function prepares a subset of character variables from the movies dataset 
#' (genre, title_type, mpaa_rating, critics_rating, audience_rating) and 
#' formats their names for display in the selection input. The year range inputs
#' are bounded by the minimum and maximum years in the dataset.
#'
#' @seealso [mod_counts_vars_server()] for the server-side logic that handles
#' these inputs
#'
#' @examples
#' # UI implementation
#' ui <- fluidPage(
#'   mod_counts_vars_ui("movie_filters")
#' )
#'
#' # Server implementation
#' server <- function(input, output, session) {
#'   filter_values <- mod_counts_vars_server("movie_filters")
#' }
mod_counts_vars_ui <- function(id) {
  # define variables 
  chr_vars <- movies[c("genre", "title_type", "mpaa_rating", 
                       "critics_rating", "audience_rating")]
  chr_nms <- names(chr_vars) |> name_case()
  chr_data <- setNames(object = chr_vars, nm = chr_nms)
  
  ns <- NS(id)
    tagList(
        varSelectInput(
          inputId = ns("chr_var"),
          label = strong("Group variable"),
          data = chr_data,
          selected = "Mpaa Rating"
        ),
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


#' Counts variable server module
#'
#' Server logic for the year range and categorical variable selection.
#'
#' @param id Module identifier
#'
#' @return A reactive list containing start_year, end_year, and chr_var
#'
#' @details This module manages the user selection of year range and categorical
#' variables. It includes validation to ensure start_year is always less than
#' end_year. When one value changes, the other adjusts automatically to maintain
#' a valid range.
#'
#' @section Logging:
#' Includes logging for input validations and changes to help diagnose user
#' interaction issues.
#'
#' @seealso [mod_counts_vars_ui()]
#' 
#' @export
#' 
mod_counts_vars_server <- function(id) {
  moduleServer(id, function(input, output, session) {
    
    logr_msg(glue::glue("Initializing counts variable module {id}"), 
             level = "DEBUG")
    
    observe({
      if (input$start_year >= input$end_year) {
        logr_msg(glue::glue("Adjusting end_year from {input$end_year} to 
                            {input$start_year + 1} as it was <= start_year"), 
                 level = "DEBUG")
        
        updateNumericInput(
          session = session, 
          inputId = "end_year", 
          value = input$start_year + 1)
      }
    }) |> 
      bindEvent(input$start_year)
    
    observe({
      if (input$end_year <= input$start_year) {
        logr_msg(glue::glue("Adjusting start_year from {input$start_year} to 
                            {input$end_year - 1} as it was >= end_year"), 
                 level = "DEBUG")
        
        updateNumericInput(
          session = session, 
          inputId = "start_year", 
          value = input$end_year - 1)
      }
    }) |> 
      bindEvent(input$end_year)
    
    return(
      reactive({
        valid_years <- req({nchar(input$start_year) == 4 & 
                           nchar(input$end_year) == 4})
        
        if (valid_years) {
          logr_msg(glue::glue("Year range set to {input$start_year}-
                              {input$end_year}, variable: {input$chr_var}"), 
                   level = "INFO")
        } else {
          logr_msg("Invalid year format detected", 
            level = "WARN")
        }
        
        list(
          "start_year" = input$start_year,
          "end_year" = input$end_year,
          "chr_var" = input$chr_var
        )
      })
    )
  })
}