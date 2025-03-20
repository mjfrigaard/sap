#' var_inputs UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList
mod_var_inputs_ui <- function(id) {
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
    )
  )
}

#' var_inputs Server Functions
#'
#' @noRd
mod_var_inputs_server <- function(id){
  moduleServer(id, function(input, output, session){
    ns <- session$ns
    return(
      reactive({
        list(
          "y" = input$y,
          "x" = input$x,
          "z" = input$z
        )
      })
    )
  })
}

## To be copied in the UI
# mod_var_inputs_ui("var_inputs_1")

## To be copied in the server
# mod_var_inputs_server("var_inputs_1")
