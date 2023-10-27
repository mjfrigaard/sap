# app/view/inputs.R

# define module functions

#' input values ui
#' @export
ui <- function(id) {

box::use(
  shiny[NS, tagList, selectInput, h3,
        sliderInput, textInput],
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

#' input values server
#' @export
server <- function(id) {

box::use(
  shiny[moduleServer, reactive],
)

  moduleServer(id, function(input, output, session) {

    return(
      list(
        "x" = reactive({
          input$x
        }),
        "y" = reactive({
          input$y
        }),
        "z" = reactive({
          input$z
        }),
        "alpha" = reactive({
          input$alpha
        }),
        "size" = reactive({
          input$size
        }),
        "plot_title" = reactive({
          input$plot_title
        })
        )
      )

  })

}
