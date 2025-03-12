## Chat args

```r
library(ellmer)
chat <- chat_openai(model = "o1", 
	system_prompt = "
  You are an expert Shiny developer and R package author. Return responses in markdown.
  
  Follow the tidyverse style guide:
  * Limit code to 80 characters per line   
  * File names should be machine readable (no spaces, symbols, or special characters)   
  * Variables and function names should all be `snake_case` (i.e., lowercase letters, numbers, and underscores to separate words within a name).   
  * Place a space before and after `=`   
  * Avoid empty lines at the start or end of functions   
  * Only use a single empty line when needed to separate functions or pipes   
  * Use verbs for function names   
  * If a function name and definition can’t fit on a single line, indent the argument name with a single indent (i.e. two spaces).   
  * Comments should be in sentence case   
  * Spread long function calls across multiple lines    
  * Always use double quotes for strings   
  * Use double quotes, not single quotes, for quoting text   
  * Use base pipe `|>` (not `%>%`)    
  ")
```

## Prompt text

```r
chat$chat("
1. Convert the following Shiny application (stored in ui.R and server.R) to use
modules for inputs and outputs (i.e., `mod_graph_inputs_ui()` and 
`mod_graph_inputs_server()`, `mod_graph_output_ui()` and 
`mod_graph_output_server()`).

2. Convert the ggvis graph output to a plotly output.

3. Place the module functions in separate app UI and server functions (i.e., 
`db_app_ui()` and `db_app_server()`)

4. Create a standalone app function (`launch_db_app()`) that launches the app 
using: `shiny::shinyApp(ui = db_app_ui(), server = db_app_server)`

The app `ui.R` code: 

\`\`\`r
library(ggvis)

# For dropdown menu
actionLink <- function(inputId, ...) {
  tags$a(href='javascript:void',
         id=inputId,
         class='action-button',
         ...)
}

fluidPage(
  titlePanel('Movie explorer'),
  fluidRow(
    column(3,
      wellPanel(
        h4('Filter'),
        sliderInput('reviews', 'Minimum number of reviews on Rotten Tomatoes',
          10, 300, 80, step = 10),
        sliderInput('year', 'Year released', 1940, 2014, value = c(1970, 2014),
          sep = ''),
        sliderInput('oscars', 'Minimum number of Oscar wins (all categories)',
          0, 4, 0, step = 1),
        sliderInput('boxoffice', 'Dollars at Box Office (millions)',
          0, 800, c(0, 800), step = 1),
        selectInput('genre', 'Genre (a movie can have multiple genres)',
          c('All', 'Action', 'Adventure', 'Animation', 'Biography', 'Comedy',
            'Crime', 'Documentary', 'Drama', 'Family', 'Fantasy', 'History',
            'Horror', 'Music', 'Musical', 'Mystery', 'Romance', 'Sci-Fi',
            'Short', 'Sport', 'Thriller', 'War', 'Western')
        ),
        textInput('director', 'Director name contains (e.g., Miyazaki)'),
        textInput('cast', 'Cast names contains (e.g. Tom Hanks)')
      ),
      wellPanel(
        selectInput('xvar', 'X-axis variable', axis_vars, selected = 'Meter'),
        selectInput('yvar', 'Y-axis variable', axis_vars, selected = 'Reviews'),
        tags$small(paste0(
          'Note: The Tomato Meter is the proportion of positive reviews',
          ' (as judged by the Rotten Tomatoes staff), and the Numeric rating is',
          ' a normalized 1-10 score of those reviews which have star ratings',
          ' (for example, 3 out of 4 stars).'
        ))
      )
    ),
    column(9,
      ggvisOutput('plot1'),
      wellPanel(
        span('Number of movies selected:',
          textOutput('n_movies')
        )
      )
    )
  )
)
\`\`\`

The app `server.R` code:

\`\`\`r
library(ggvis)
library(dplyr)
if (FALSE) {
  library(RSQLite)
  library(dbplyr)
}

# Set up handles to database tables on app start
db <- src_sqlite('movies.db')
omdb <- tbl(db, 'omdb')
tomatoes <- tbl(db, 'tomatoes')

# Join tables, filtering out those with <10 reviews, and select specified columns
all_movies <- inner_join(omdb, tomatoes, by = 'ID') %>%
  filter(Reviews >= 10) %>%
  select(ID, imdbID, Title, Year, Rating_m = Rating.x, Runtime, Genre, Released,
    Director, Writer, imdbRating, imdbVotes, Language, Country, Oscars,
    Rating = Rating.y, Meter, Reviews, Fresh, Rotten, userMeter, userRating, userReviews,
    BoxOffice, Production, Cast)


function(input, output, session) {

  # Filter the movies, returning a data frame
  movies <- reactive({
    # Due to dplyr issue #318, we need temp variables for input values
    reviews <- input$reviews
    oscars <- input$oscars
    minyear <- input$year[1]
    maxyear <- input$year[2]
    minboxoffice <- input$boxoffice[1] * 1e6
    maxboxoffice <- input$boxoffice[2] * 1e6

    # Apply filters
    m <- all_movies %>%
      filter(
        Reviews >= reviews,
        Oscars >= oscars,
        Year >= minyear,
        Year <= maxyear,
        BoxOffice >= minboxoffice,
        BoxOffice <= maxboxoffice
      ) %>%
      arrange(Oscars)

    # Optional: filter by genre
    if (input$genre != 'All') {
      genre <- paste0('%', input$genre, '%')
      m <- m %>% filter(Genre %like% genre)
    }
    # Optional: filter by director
    if (!is.null(input$director) && input$director != '') {
      director <- paste0('%', input$director, '%')
      m <- m %>% filter(Director %like% director)
    }
    # Optional: filter by cast member
    if (!is.null(input$cast) && input$cast != '') {
      cast <- paste0('%', input$cast, '%')
      m <- m %>% filter(Cast %like% cast)
    }


    m <- as.data.frame(m)

    # Add column which says whether the movie won any Oscars
    # Be a little careful in case we have a zero-row data frame
    m$has_oscar <- character(nrow(m))
    m$has_oscar[m$Oscars == 0] <- 'No'
    m$has_oscar[m$Oscars >= 1] <- 'Yes'
    m
  })

  # Function for generating tooltip text
  movie_tooltip <- function(x) {
    if (is.null(x)) return(NULL)
    if (is.null(x$ID)) return(NULL)

    # Pick out the movie with this ID
    all_movies <- isolate(movies())
    movie <- all_movies[all_movies$ID == x$ID, ]

    paste0('<b>', movie$Title, '</b><br>',
      movie$Year, '<br>',
      '$', format(movie$BoxOffice, big.mark = ',', scientific = FALSE)
    )
  }

  # A reactive expression with the ggvis plot
  vis <- reactive({
    # Lables for axes
    xvar_name <- names(axis_vars)[axis_vars == input$xvar]
    yvar_name <- names(axis_vars)[axis_vars == input$yvar]

    # Normally we could do something like props(x = ~BoxOffice, y = ~Reviews),
    # but since the inputs are strings, we need to do a little more work.
    xvar <- prop('x', as.symbol(input$xvar))
    yvar <- prop('y', as.symbol(input$yvar))

    movies %>%
      ggvis(x = xvar, y = yvar) %>%
      layer_points(size := 50, size.hover := 200,
        fillOpacity := 0.2, fillOpacity.hover := 0.5,
        stroke = ~has_oscar, key := ~ID) %>%
      add_tooltip(movie_tooltip, 'hover') %>%
      add_axis('x', title = xvar_name) %>%
      add_axis('y', title = yvar_name) %>%
      add_legend('stroke', title = 'Won Oscar', values = c('Yes', 'No')) %>%
      scale_nominal('stroke', domain = c('Yes', 'No'),
        range = c('orange', '#aaa')) %>%
      set_options(width = 500, height = 500)
  })

  vis %>% bind_shiny('plot1')

  output$n_movies <- renderText({ nrow(movies()) })
}
\`\`\`

")


## Response

```r
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

# mod_graph_output.R
mod_graph_output_ui <- function(id) {
  ns <- shiny::NS(id)
  shiny::tagList(
    plotly::plotlyOutput(outputId = ns("plot1")),
    shiny::wellPanel(
      shiny::span(
        "Number of movies selected:",
        shiny::textOutput(ns("n_movies"))
      )
    )
  )
}

mod_graph_output_server <- function(id, inputs_list) {
  shiny::moduleServer(
    id,
    function(input, output, session) {
      
      # Render a plotly chart
      output$plot1 <- plotly::renderPlotly({
        xvar <- inputs_list()$xvar
        yvar <- inputs_list()$yvar
        movie_data <- inputs_list()$data
        
        # Axis label from named vector
        xvar_label <- names(axis_vars)[axis_vars == xvar]
        yvar_label <- names(axis_vars)[axis_vars == yvar]
        
        if (is.null(movie_data) || nrow(movie_data) == 0) {
          return(NULL)
        }
        
        # Construct the tooltip
        tooltip_text <- paste0(
          "<b>", movie_data$Title, "</b><br>",
          movie_data$Year, "<br>$",
          format(movie_data$BoxOffice, big.mark = ",", scientific = FALSE)
        )
        
        plotly::plot_ly(
          data = movie_data,
          x = ~.data[[xvar]],
          y = ~.data[[yvar]],
          text = tooltip_text,
          hoverinfo = "text",
          color = ~factor(has_oscar, levels = c("Yes", "No")),
          colors = c("orange", "#aaa"),
          type = "scatter",
          mode = "markers"
        ) |>
          plotly::layout(
            xaxis = list(title = xvar_label),
            yaxis = list(title = yvar_label),
            showlegend = TRUE
          )
      })
      
      output$n_movies <- shiny::renderText({
        nrow(inputs_list()$data)
      })
    }
  )
}

# db_app_ui.R
db_app_ui <- function() {
  shiny::fluidPage(
    shiny::titlePanel("Movie explorer"),
    shiny::fluidRow(
      shiny::column(
        width = 3,
        mod_graph_inputs_ui("graph_inputs")
      ),
      shiny::column(
        width = 9,
        mod_graph_output_ui("graph_outputs")
      )
    )
  )
}

# db_app_server.R
db_app_server <- function(input, output, session) {
  
  # Set up handles to database tables on app start
  db <- dplyr::src_sqlite("movies.db")
  omdb <- dplyr::tbl(db, "omdb")
  tomatoes <- dplyr::tbl(db, "tomatoes")
  
  # Join tables, filter out those with <10 reviews, and select
  all_movies <- dplyr::inner_join(omdb, tomatoes, by = "ID") |>
    dplyr::filter(Reviews >= 10) |>
    dplyr::select(
      ID, imdbID, Title, Year, Rating_m = Rating.x, Runtime, Genre,
      Released, Director, Writer, imdbRating, imdbVotes, Language,
      Country, Oscars, Rating = Rating.y, Meter, Reviews, Fresh, Rotten,
      userMeter, userRating, userReviews, BoxOffice, Production, Cast
    )
  
  # Call module for inputs
  inputs_reactive <- mod_graph_inputs_server(
    id = "graph_inputs",
    all_movies = all_movies
  )
  
  # Call module for outputs
  mod_graph_output_server(
    id = "graph_outputs",
    inputs_list = inputs_reactive
  )
}

# A named vector of possible axis variables
axis_vars <- c(
  "Meter" = "Meter",
  "Reviews" = "Reviews",
  "Box office" = "BoxOffice",
  "IMDB rating" = "imdbRating",
  "IMDB votes" = "imdbVotes",
  "User meter" = "userMeter",
  "User rating" = "userRating"
)

# Standalone app function
launch_db_app <- function() {
  shiny::shinyApp(
    ui = db_app_ui(),
    server = db_app_server
  )
}
```

Explanation of major changes:
• The ggvis plot and bindings have been replaced with a plotly plot.  
• The UI for the plot is now plotlyOutput rather than ggvisOutput.  
• The "movie_tooltip" logic is approximated through Plotly's "text" and "hoverinfo = 
'text'".  
• Modules (mod_graph_inputs_*) handle filtering inputs, and modules 
(mod_graph_output_*) handle the plotly plot output plus the count of displayed movies.

• db_app_ui() and db_app_server() assemble everything, and launch_db_app() calls 
shiny::shinyApp() with those functions.