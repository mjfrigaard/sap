#' Inputs Module UI
#'
#' @param id Module namespace
#' @return Shiny UI element
mod_inputs_ui <- function(id) {
  ns <- NS(id)

  numeric_choices <- c(
    "runtime",
    "imdb_rating",
    "imdb_num_votes",
    "critics_score",
    "audience_score"
  )

  color_choices <- c(
    "genre",
    "mpaa_rating",
    "critics_rating",
    "title_type",
    "audience_rating"
  )

  genre_choices <- c(
    "All",
    "Action & Adventure",
    "Animation",
    "Art House & International",
    "Comedy",
    "Documentary",
    "Drama",
    "Horror",
    "Musical & Performing Arts",
    "Mystery & Suspense",
    "Other",
    "Science Fiction & Fantasy"
  )

  tagList(
    strong("Visualization Controls"),
    selectInput(
      ns("x_var"),
      "X Variable:",
      choices = numeric_choices,
      selected = "critics_score"
    ),
    selectInput(
      ns("y_var"),
      "Y Variable:",
      choices = numeric_choices,
      selected = "audience_score"
    ),
    selectInput(
      ns("col_var"),
      "Color Variable:",
      choices = color_choices,
      selected = "genre"
    ),
    sliderInput(
      ns("alpha_var"),
      "Point Alpha:",
      min = 0,
      max = 1,
      value = 0.7,
      step = 0.05
    ),
    sliderInput(
      ns("size_var"),
      "Point Size:",
      min = 1,
      max = 6,
      value = 3,
      step = 0.5
    ),
    strong("Data Filter"),
    selectInput(
      ns("genre_filter"),
      "Filter by Genre:",
      choices = genre_choices,
      selected = "All"
    )
  )
}

#' Inputs Module Server
#'
#' @param id Module namespace
#' @return List of reactive values
mod_inputs_server <- function(id) {
  moduleServer(id, function(input, output, session) {

    return(list(
      x_var = reactive(input$x_var),
      y_var = reactive(input$y_var),
      col_var = reactive(input$col_var),
      alpha_var = reactive(input$alpha_var),
      size_var = reactive(input$size_var),
      genre_filter = reactive(input$genre_filter)
    ))
  })
}
