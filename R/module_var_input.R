#' var_input UI
#'
#' @param id Unique id for module instance.
#'
#' @keywords internal
#'
#' @return shiny UI module
#' @export var_inputUI
#'
#' @description A shiny Module.
#'
var_inputUI <- function(id) {
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

#' var_input Server
#'
#' @param id Unique id for module instance.
#'
#' @keywords internal
#'
#' @return shiny server module
#' @export var_input_server
#'
var_input_server <- function(id) {
  moduleServer(id, function(input, output, session) {
      ns <- session$ns
      send_message <- make_send_message(session)

      # your code here
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
    }
  )
}

# UI
# var_inputUI('id')

# server
# var_input_server('id')
