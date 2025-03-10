#' name shiny module (UI)
#'
#' @param id shiny module id
#'
#' @export
#' 
mod_select_input_ui <- function(id) {

    # Variables that can be put on the x and y axes
    axis_vars <- c(
      "Tomato Meter" = "meter",
      "Numeric Rating (OMDB)" = "omdb_ratings",
      "Numeric Rating (RT)" = "rt_ratings",
      "Number of reviews" = "reviews",
      "Dollars at box office" = "box_office",
      "Year" = "year",
      "Length (minutes)" = "runtime"
    )
    ns <- shiny::NS(id)
        shiny::tagList(
        selectInput(
          inputId = ns("genre"),
          label = strong("Genre*"),
          c("All",
            "Action",
            "Adventure",
            "Animation",
            "Biography",
            "Comedy",
            "Crime",
            "Documentary",
            "Drama",
            "Family",
            "Fantasy",
            "History",
            "Horror",
            "Music",
            "Musical",
            "Mystery",
            "Romance",
            "Sci-Fi",
            "Short",
            "Sport",
            "Thriller",
            "War",
            "Western")),
        tags$small(em("*a movie can have multiple genres")),
        selectInput(inputId = ns("xvar"),
          label = strong("X-axis variable"),
          axis_vars,
          selected = "meter"),
        selectInput(inputId = ns("yvar"),
          label = strong("Y-axis variable"),
          choices = axis_vars,
          selected = "runtime")
        )
    }
#' name shiny module (server)
#'
#' @param id shiny module id
#'
#' @export
#' 
mod_select_input_server <- function(id) {
    shiny::moduleServer(id, function(input, output, session) {
        ns <- session$ns
      return(
        reactive(
          list(
          'yvar' = input$yvar,
          'xvar' = input$xvar,
          'genre' = input$genre
          )
        )
      )

    })
}
