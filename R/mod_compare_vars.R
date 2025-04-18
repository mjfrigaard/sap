#' UI module for comparing movie variables
#'
#' @param id A string. The module ID.
#'
#' @returns A UI element containing inputs for selecting variables to compare 
#' in a scatter plot, including X and Y variables, color variable, and
#' customization controls for alpha, size, and plot title.
#'
#' @export
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

#' Server function for comparing variables
#'
#' @param id A single string identifying the module.
#'
#' @returns A reactive list containing the plot parameters: x variable, y variable,
#' color, alpha, size, and title.
#'
#' @details This server function manages the selection of variables for comparison
#' plots. It ensures that x and y variables cannot be the same by updating the 
#' selection when needed. The function returns a reactive list with all 
#' plot parameters.
#'
#' @section Logging:
#' This module uses log messages to track variable selections and updates.
#'
#' @seealso \code{mod_compare_vars_ui()} for the UI components of this module.
#'
#' @export
#' 
mod_compare_vars_server <- function(id) {
  moduleServer(id, function(input, output, session) {
    
    logr_msg(glue::glue("Initializing compare vars module with id: {id}"), 
    level = "INFO")
    
    observe({
      logr_msg(glue::glue("X variable selected: {input$var_x}"), level = "DEBUG")
      
      if (input$var_x == input$var_y) {
        logr_msg("X and Y variables match. Updating Y selection.", level = "WARN")
        
        num_cols <- c("audience_score", "critics_score", "imdb_num_votes", 
        "imdb_rating", "runtime")
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
      logr_msg(glue::glue("Y variable selected: {input$var_y}"), level = "DEBUG")
      
      if (input$var_y == input$var_x) {
        logr_msg("Y and X variables match. Updating X selection.", level = "WARN")
        
        num_cols <- c("audience_score", "critics_score", "imdb_num_votes",
        "imdb_rating", "runtime")
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
    
    # Return reactive list of plot parameters
    plot_params <- reactive({
      params <- list(
        "x" = input$var_x,
        "y" = input$var_y,
        "color" = input$color,
        "alpha" = input$alpha,
        "size" = input$size,
        "title" = input$plot_title
      )
      
      logr_msg("Plot parameters updated with new values", level = "TRACE")
      logr_msg(glue::glue("Current plot parameters: {paste(names(params), 
      unlist(params), sep='=', collapse=', ')}"), 
      level = "DEBUG")
      
      params
    })
    
    return(plot_params)
  })
}