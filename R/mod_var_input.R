#' Variable input module (UI)
#' 
#' @description
#' `var_input` collects the following graph inputs:
#'  * `input$x`
#'  * `input$y`
#'  * `input$z`
#'  * `input$alpha`
#'  * `input$size`
#'  * `input$plot_title`
#'
#' @param id UI module id
#'
#' @return module UI (HTML)
#' 
#' @seealso [mod_var_input_server()]
#' 
#' @keywords internal
mod_var_input_ui <- function(id) {
  ns <- NS(id)
  tagList(
    selectInput(
      inputId = ns("y"),
      label = "Y-axis:",
      choices = c(
        "IMDB rating" = "imdb_rating",
        "IMDB number of votes" = "imdb_num_votes",
        "Critics Score" = "critics_score",
        "Audience Score" = "audience_score",
        "Runtime" = "runtime"
      ),
      selected = "audience_score"
    ),
    selectInput(
      inputId = ns("x"),
      label = "X-axis:",
      choices = c(
        "IMDB rating" = "imdb_rating",
        "IMDB number of votes" = "imdb_num_votes",
        "Critics Score" = "critics_score",
        "Audience Score" = "audience_score",
        "Runtime" = "runtime"
      ),
      selected = "imdb_rating"
    ),
    selectInput(
      inputId = ns("z"),
      label = "Color by:",
      choices = c(
        "Title Type" = "title_type",
        "Genre" = "genre",
        "MPAA Rating" = "mpaa_rating",
        "Critics Rating" = "critics_rating",
        "Audience Rating" = "audience_rating"
      ),
      selected = "mpaa_rating"
    ),
    sliderInput(
      inputId = ns("alpha"),
      label = "Alpha:",
      min = 0, max = 1, step = 0.1,
      value = 0.5
    ),
    sliderInput(
      inputId = ns("size"),
      label = "Size:",
      min = 0, max = 5,
      value = 2
    ),
    textInput(
      inputId = ns("plot_title"),
      label = "Plot title",
      placeholder = "Enter plot title"
    )
  )
}

#' Variable input module (server)
#'
#' @param id server module id
#' 
#' @seealso [mod_var_input_ui()]
#'
#' @return reactive inputs are returned in a `list()`: 
#'  * `"y" = input$y`
#'  * `"x" = input$x`
#'  * `"z" = input$z`
#'  * `"alpha" = input$alpha`
#'  * `"size" = input$size`
#'  * `"plot_title" = input$plot_title`
#'  
#' These become in the `var_inputs` argument in [mod_scatter_display_server()]
#' 
#' @keywords internal
mod_var_input_server <- function(id) {

  moduleServer(id, function(input, output, session) {
    return(
      reactive({
        list(
          "y" = input$y,
          "x" = input$x,
          "z" = input$z,
          "alpha" = input$alpha,
          "size" = input$size,
          "plot_title" = input$plot_title
        )
      })
    )
  })
}