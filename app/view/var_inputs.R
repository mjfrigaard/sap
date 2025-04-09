# app/view/var_inputs.R

# define module functions

#' variable input values ui
#' @export
ui <- function(id) {
  box::use(
    shiny[
      NS, tagList, selectInput
    ],
  )
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

#' variable input values server
#' @export
server <- function(id) {
  box::use(
    shiny[moduleServer, reactive],
  )

  moduleServer(id, function(input, output, session) {
    return(
      reactive({
        list(
          "x" = input$x,
          "y" = input$y,
          "z" = input$z
        )
      })
    )
  })
}
