#' UI for variable comparison module
#'
#' Creates inputs for selecting variables to compare in a scatter plot with 
#' customizable appearance options. This function is designed to work together 
#' with [mod_compare_vars_server()].
#'
#' @param id A character string used to identify the namespace for the module.
#'
#' @return A `tagList` containing UI elements:
#'   * Variable selection inputs for X and Y axes
#'   * Variable selection for color grouping
#'   * Sliders for point alpha (transparency) and size
#'   * Text input for plot title customization
#'
#' @details
#' The function prepares two sets of variables from the movies dataset:
#'   * Numeric variables: runtime, IMDB rating, IMDB vote count, critics score,
#'     and audience score for the X and Y axis selections
#'   * Categorical variables: MPAA rating, genre, and critics rating for the
#'     color grouping option
#'
#' Variable names are formatted using the `name_case()` helper function to
#' improve readability in the UI.
#'
#' @seealso [mod_compare_vars_server()] for the server-side logic
#'
#' @examples
#' # UI implementation
#' ui <- fluidPage(
#'   mod_compare_vars_ui("compare1")
#' )
#'
#' # Server implementation
#' server <- function(input, output, session) {
#'   plot_inputs <- mod_compare_vars_server("compare1")
#' }
#'
mod_compare_vars_ui <- function(id) {

  num_vars <- movies[c("runtime", "imdb_rating",
                       "imdb_num_votes", "critics_score",
                        "audience_score")]
  num_nms <- names(num_vars) |> name_case()
  
  num_data <- setNames(object = num_vars, nm = num_nms)
  
  chr_vars <- movies[c("mpaa_rating", "genre", "critics_rating")]
  chr_nms <- names(chr_vars) |> name_case()
  chr_data <- setNames(object = chr_vars, nm = chr_nms)

  ns <- NS(id)
  tagList(
    varSelectInput(
      inputId = ns("var_x"),
      label = strong("X variable"),
      data = num_data,
      selected = "Imdb Rating"
    ),
    varSelectInput(
      inputId = ns("var_y"),
      label = strong("Y variable"),
      data = num_data,
      selected = "Audience Score"
    ),
    varSelectInput(
      inputId = ns("color"),
      label = strong("Color by:"),
      data = chr_data,
      selected = "Critics Rating"
    ),
    sliderInput(
      inputId = ns("alpha"),
      label = strong("Alpha"),
      min = 0.5, 
      max = 1.0, 
      step = 0.1,
      value = 0.7
    ),
    sliderInput(
      inputId = ns("size"),
      label = strong("Size"),
      min = 5, 
      max = 10,
      step = 0.5,
      value = 7
    ),
    textInput(
      inputId = ns("plot_title"),
      label = strong("Plot title"),
      placeholder = "Enter plot title"
    )
  )
}

#' Server Logic for Variable Selection
#' 
#' This function handles the logic for variable selection, ensuring that
#' x and y variables are different. 
#'
#' @param id Shiny module ID.
#'
#' @return A reactive list of selected variables and plot attributes.
#' 
#' @details When a user selects the same variable for both axes, the other 
#' input is automatically updated to a different choice.
#'   
#' @section Logging:
#'   Includes logging for variable selection changes and validation.
#'
#' @seealso [mod_compare_vars_ui()]
#' 
#' @export
#' 
mod_compare_vars_server <- function(id) {
  moduleServer(id, function(input, output, session) {
    
    logr_msg("Initializing variable comparison module", level = "INFO")
    
    observe({
      logr_msg(glue::glue("X variable changed to: {input$var_x}"), 
        level = "DEBUG")
      
      if (input$var_x == input$var_y) {
        logr_msg("X and Y variables match, updating Y selection", level = "WARN")
        num_cols <- name_case(c("audience_score", "critics_score", "imdb_num_votes", 
          "imdb_rating", "runtime"), case = "title")
        y_cols <- num_cols[num_cols != input$var_x]
        
        updateSelectInput(
          session = session, 
          inputId = "var_y", 
          choices = y_cols, 
          selected = y_cols[1]
        ) 
        
        logr_msg(glue::glue("Y variable auto-updated to: {y_cols[1]}"), 
          level = "INFO")
      }
    }) |> 
      bindEvent(input$var_x)
    
    observe({
      logr_msg(glue::glue("Y variable changed to: {input$var_y}"), 
        level = "DEBUG")
      
      if (input$var_y == input$var_x) {
        logr_msg("Y and X variables match, updating X selection", level = "WARN")
        num_cols <- name_case(c("audience_score", "critics_score", 
          "imdb_num_votes", "imdb_rating", "runtime"))
        x_cols <- num_cols[num_cols != input$var_y]
        
        updateSelectInput(
          session = session,
          inputId = "var_x",
          choices = x_cols,
          selected = x_cols[1]
        )
        
        logr_msg(glue::glue("X variable auto-updated to: {x_cols[1]}"), 
          level = "INFO")
      }
    }) |>
      bindEvent(input$var_y)
    
    # Return selected variables as reactive list
    logr_msg("Variable comparison module ready", level = "TRACE")
    
    return(
      reactive({
        logr_msg("Variable selections updated", level = "DEBUG")
        list(
          "x" = input$var_x,
          "y" = input$var_y,
          "color" = input$color,
          "alpha" = input$alpha,
          "size" = input$size,
          "title" = input$plot_title
        )
      })
    )
  })
}