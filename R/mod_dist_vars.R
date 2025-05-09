#' UI for distribution variables module
#'
#' Creates inputs for selecting variables and customizing the appearance of
#' distribution plots. This function provides controls for choosing a categorical
#' variable for grouping/coloring and a numeric variable for the x-axis, along
#' with appearance settings. This function is designed to work together with
#' [mod_dist_vars_server()].
#'
#' @param id A character string used to identify the namespace for the module.
#'
#' @return A `tagList` containing UI elements:
#'   * A variable select input for the categorical grouping variable
#'   * A variable select input for the numeric variable
#'   * A section header for customization options
#'   * A slider input for controlling transparency (alpha)
#'   * A slider input for controlling point/element size
#'
#' @seealso [mod_dist_vars_server()] for the server-side logic
#'
#' @examples
#' # UI implementation
#' ui <- fluidPage(
#'   mod_dist_vars_ui("dist_vars1")
#' )
#'
#' # Server implementation
#' server <- function(input, output, session) {
#'   vars <- mod_dist_vars_server("dist_vars1")
#' }
#'
mod_dist_vars_ui <- function(id) {
  num_data <- movies[c("critics_score", "audience_score", "runtime", 
                       "imdb_rating")]
  num_nms <- names(num_data) |> name_case()
  num_data <- setNames(num_data, num_nms)
  
  rating_data <- movies[c("critics_rating", "audience_rating")]
  rating_nms <- names(rating_data) |> name_case()
  rating_data <- setNames(rating_data, rating_nms)

  ns <- NS(id)
  tagList(
    varSelectInput(
      inputId = ns("chr_var"),
      label = a(strong("Y (Color/group variable)")),
      data = rating_data,
      selected = "Critics Rating"
    ),
    varSelectInput(
      inputId = ns("num_var"),
      label = a(strong("X (Numeric variable)")),
      data = num_data,
      selected = "Audience Score"
    ),
    markdown("**Customize**"),
    sliderInput(
      inputId = ns("alpha"),
      label = "Alpha",
      min = 0.2, 
      max = 1.0, 
      step = 0.2,
      value = 0.8
    ),
    sliderInput(
      inputId = ns("size"),
      label = "Size/scale",
      min = 1, 
      max = 5,
      step = 0.5,
      value = 3.0
    )
  )
}

#' Server Logic for Variable Selection
#'
#' @param id Shiny module ID
#' 
#' @return A reactive list of selected variables and plot attributes
#' 
#' @seealso [mod_dist_vars_ui()] for the corresponding UI components
#'
#' @details
#' This server module tracks user-selected variables and plot aesthetic
#' parameters. The function returns a reactive list containing numeric variables,
#' character variables, and plot attribute settings (alpha and size) which can be
#' consumed by downstream visualization modules.
#' 
#' @export
#' 
mod_dist_vars_server <- function(id) {
  moduleServer(id, function(input, output, session) {
    
    logr_msg("Initializing distribution variables module", 
      level = "DEBUG")
    
    # create reactive to track selected variables
    selected_vars <- reactive({
      logr_msg(glue::glue("Variables updated: num={input$num_var}, 
      chr={input$chr_var}"), 
        level = "TRACE")
      
      if (is.null(input$num_var) || is.null(input$chr_var)) {
        logr_msg("Missing required variable selections", 
          level = "WARN")
      }
      
      list(
        "num_var" = input$num_var,
        "chr_var" = input$chr_var,
        "alpha" = input$alpha,
        "size" = input$size
      )
    })
    
    logr_msg("Distribution variables module initialized", 
      level = "DEBUG")
    
    return(selected_vars)
  })
}