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
          selected = "Critics Rating"
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

#'
#' Server for counts variables module
#'
#' Processes user inputs for date ranges and categorical variables, with 
#' validation to ensure proper date ordering. This function is designed to
#' work together with a corresponding UI function.
#'
#' @param id A character string used to identify the namespace for the module.
#'
#' @return A reactive list containing three elements:
#'   * `start_year`: The numeric start year value
#'   * `end_year`: The numeric end year value
#'   * `chr_var`: The selected categorical variable
#'
#' The return value is reactive and updates whenever the inputs change.
#'
#' @details
#' The function includes two observers that maintain proper date ordering:
#'   * If `start_year` becomes greater than or equal to `end_year`, 
#'     `end_year` is automatically updated
#'   * If `end_year` becomes less than or equal to `start_year`, 
#'     `start_year` is automatically updated
#'
#' The reactive return value requires both year inputs to be valid 4-digit years.
#'
#' @seealso The corresponding UI function that creates the input elements
#'
#' @examples
#' # Server implementation
#' server <- function(input, output, session) {
#'   vars <- mod_counts_vars_server("counts_vars")
#'   # Use the reactive variables elsewhere
#'   observe({
#'     req(vars())
#'     print(paste("Date range:", vars()$start_year, "to", vars()$end_year))
#'   })
#' }
#'
#'
#'
#'
#'
mod_counts_vars_server <- function(id) {
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
          "chr_var" = input$chr_var
        )
      })
    )
  })
}
