# mod_graph_inputs.R
mod_graph_inputs_ui <- function(id) {
  ns <- shiny::NS(id)
  shiny::tagList(
    shiny::wellPanel(
      shiny::h4("Filter"),
      shiny::sliderInput(
        inputId = ns("reviews"),
        label = "Minimum number of reviews on Rotten Tomatoes",
        min = 10,
        max = 300,
        value = 80,
        step = 10
      ),
      shiny::sliderInput(
        inputId = ns("year"),
        label = "Year released",
        min = 1940,
        max = 2014,
        value = c(1970, 2014),
        sep = ""
      ),
      shiny::sliderInput(
        inputId = ns("oscars"),
        label = "Minimum number of Oscar wins (all categories)",
        min = 0,
        max = 4,
        value = 0,
        step = 1
      ),
      shiny::sliderInput(
        inputId = ns("boxoffice"),
        label = "Dollars at Box Office (millions)",
        min = 0,
        max = 800,
        value = c(0, 800),
        step = 1
      ),
      shiny::selectInput(
        inputId = ns("genre"),
        label = "Genre (a movie can have multiple genres)",
        choices = c(
          "All", "Action", "Adventure", "Animation", "Biography", "Comedy",
          "Crime", "Documentary", "Drama", "Family", "Fantasy", "History",
          "Horror", "Music", "Musical", "Mystery", "Romance", "Sci-Fi",
          "Short", "Sport", "Thriller", "War", "Western"
        ),
        selected = "All"
      ),
      shiny::textInput(
        inputId = ns("director"),
        label = "Director name contains (e.g., Miyazaki)"
      ),
      shiny::textInput(
        inputId = ns("cast"),
        label = "Cast names contains (e.g. Tom Hanks)"
      )
    ),
    shiny::wellPanel(
      shiny::selectInput(
        inputId = ns("xvar"),
        label = "X-axis variable",
        choices = axis_vars,
        selected = "Meter"
      ),
      shiny::selectInput(
        inputId = ns("yvar"),
        label = "Y-axis variable",
        choices = axis_vars,
        selected = "Reviews"
      ),
      shiny::tags$small(
        shiny::p(
          paste0(
            "Note: The Tomato Meter is the proportion of positive reviews ",
            "(as judged by the Rotten Tomatoes staff), and the Numeric rating ",
            "is a normalized 1-10 score of those reviews which have star ",
            "ratings (for example, 3 out of 4 stars)."
          )
        )
      )
    )
  )
}

mod_graph_inputs_server <- function(id, all_movies) {
  shiny::moduleServer(
    id,
    function(input, output, session) {
      # Filter movies based on user inputs
      movies <- shiny::reactive({
        reviews <- input$reviews
        oscars <- input$oscars
        minyear <- input$year[1]
        maxyear <- input$year[2]
        minboxoffice <- input$boxoffice[1] * 1e6
        maxboxoffice <- input$boxoffice[2] * 1e6
        
        m <- all_movies |>
          dplyr::filter(
            Reviews >= reviews,
            Oscars >= oscars,
            Year >= minyear,
            Year <= maxyear,
            BoxOffice >= minboxoffice,
            BoxOffice <= maxboxoffice
          ) |>
          dplyr::arrange(Oscars)
        
        if (input$genre != "All") {
          genre <- paste0("%", input$genre, "%")
          m <- m |>
            dplyr::filter(Genre %like% genre)
        }
        
        if (!is.null(input$director) && input$director != "") {
          director <- paste0("%", input$director, "%")
          m <- m |>
            dplyr::filter(Director %like% director)
        }
        
        if (!is.null(input$cast) && input$cast != "") {
          cast <- paste0("%", input$cast, "%")
          m <- m |>
            dplyr::filter(Cast %like% cast)
        }
        
        m <- as.data.frame(m)
        m$has_oscar <- character(nrow(m))
        m$has_oscar[m$Oscars == 0] <- "No"
        m$has_oscar[m$Oscars >= 1] <- "Yes"
        m
      })
      
      # Return a reactive list giving the xvar, yvar, and filtered data
      shiny::reactive({
        list(
          xvar = input$xvar,
          yvar = input$yvar,
          data = movies()
        )
      })
    }
  )
}