#' vars UI
#'
#' @param id Unique id for module instance.
#'
#' @keywords internal
varsUI <- function(id){
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

#' vars Server
#'
#' @param id Unique id for module instance.
#'
#' @keywords internal
vars_server <- function(id){
    moduleServer(
        id,
        function(
            input,
            output,
            session
            ){

                ns <- session$ns
                send_message <- make_send_message(session)

      return(
        reactive({
          list(
            "y" = input$y,
            "x" = input$x,
            "z" = input$z
          )
        })
      )
        }
    )
}

# UI
# varsUI('id')

# server
# vars_server('id')
