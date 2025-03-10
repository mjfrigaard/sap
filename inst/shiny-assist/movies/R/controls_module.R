#' Controls Module UI
#'
#' UI function for the movie visualization controls module.
#'
#' @param id A character vector used to identify the namespace for this module
#'
#' @return A UI definition for the controls module
#'
#'
#' @export
#' 
controlsUI <- function(id) {
  ns <- NS(id)
  tagList(
    selectInput(inputId = ns("x_var"), label = "X-axis Variable:", 
                choices = c("runtime", "year", "imdb_rating", 
                            "imdb_num_votes", "critics_score", "audience_score"),
                selected = "imdb_rating"),
    
    selectInput(inputId = ns("y_var"), label = "Y-axis Variable:", 
                choices = c("runtime", "year", "imdb_rating", 
                            "imdb_num_votes", "critics_score", "audience_score"),
                selected = "audience_score"),
    
    selectInput(inputId = ns("color_var"), label = "Color by:", 
                choices = c("None" = "none", 
                            "genre", "mpaa_rating", "critics_rating", 
                            "audience_rating", "best_pic_nom", "best_pic_win", 
                            "best_actor_win", "best_actress_win", "best_dir_win"),
                selected = "mpaa_rating"),
    
    sliderInput(inputId = ns("point_size"), label = "Point Size:", 
                min = 1, max = 10, value = 3, step = 0.5),
    
    sliderInput(inputId = ns("alpha"), label = "Transparency:", 
                min = 0.1, max = 1, value = 0.7, step = 0.1),
    
    hr(),
    
    textInput(inputId = ns("plot_title"), label = "Plot Title:",
     value = "IMDB Movie Visualization"),
    
    checkboxInput(inputId = ns("show_labels"), label = "Show Movie Titles", 
                  value = FALSE)
  )
}

#' Controls Module Server
#'
#' Server function for the movie visualization controls module.
#'
#' @param id A character vector used to identify the namespace for this module
#'
#' @return A reactive list containing all input values
#'
#' @export
#' 
controlsServer <- function(id) {
  moduleServer(id, function(input, output, session) {
    # Return all inputs as a reactive list
    return(
      reactive({
      list(
        x_var = input$x_var,
        y_var = input$y_var,
        color_var = input$color_var, 
        point_size = input$point_size,
        alpha = input$alpha,
        plot_title = input$plot_title,
        show_labels = input$show_labels
      )
    })
    )
  })
}
