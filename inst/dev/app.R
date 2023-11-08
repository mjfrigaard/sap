options(scipen = 100000000)

make_dev_ggp2_movies <- function(con) {
  movies_data <- read.csv(file = con)
  # specify genre columns
  genre_cols <- c(
    "Action", "Animation",
    "Comedy", "Drama",
    "Documentary", "Romance",
    "Short"
  )
  # calculate row sum for genres
  movies_data$genre_count <- rowSums(movies_data[, genre_cols])
  # create aggregate 'genres' for multiple categories
  movies_data$genres <- apply(
    X = movies_data[, genre_cols],
    MARGIN = 1,
    FUN = function(row) {
      genres <- names(row[row == 1])
      if (length(genres) > 0) {
        return(paste(genres, collapse = ", "))
      } else {
        return(NA)
      }
    }
  )
  # format variables
  movies_data$genre_count <- as.integer(movies_data$genre_count)
  movies_data$genre <- ifelse(test = movies_data$genre_count > 1,
    yes = "Multiple genres",
    no = movies_data$genres
  )
  movies_data$genre <- as.factor(movies_data$genre)
  movies_data$mpaa <- factor(movies_data$mpaa,
    levels = c("G", "PG", "PG-13", "R", "NC-17"),
    labels = c("G", "PG", "PG-13", "R", "NC-17")
  )

  # reduce columns to only those in graph
  movies_data[, c(
    "title", "year", "length", "budget",
    "rating", "votes", "mpaa", "genre_count",
    "genres", "genre"
  )]
}

dev_mod_vars_ui <- function(id) {
  ns <- NS(id)
  tagList(
    textInput(
      inputId = ns("plot_title"),
      label = "Plot title",
      placeholder = "Enter plot title"
    ),
    selectInput(
      inputId = ns("y"),
      label = "Y-axis:",
      choices = c(
        "Year" = "year",
        "Length" = "length",
        "Budget" = "budget",
        "Rating" = "rating",
        "Votes" = "votes"
      ),
      selected = "budget"
    ),
    selectInput(
      inputId = ns("x"),
      label = "X-axis:",
      choices = c(
        "Year" = "year",
        "Length" = "length",
        "Budget" = "budget",
        "Rating" = "rating",
        "Votes" = "votes"
      ),
      selected = "year"
    ),
    selectInput(
      inputId = ns("z"),
      label = "Color by:",
      choices = c(
        "MPAA" = "mpaa",
        "Genre" = "genre"
      ),
      selected = "mpaa"
    ),
    sliderInput(
      inputId = ns("alpha"),
      label = "Alpha:",
      min = 0, max = 1, step = 0.1,
      value = 0.4
    ),
    sliderInput(
      inputId = ns("size"),
      label = "Size:",
      min = 0, max = 5, step = 0.5,
      value = 2.5
    ),
    verbatimTextOutput(ns("vals"))
  )
}

dev_mod_scatter_ui <- function(id) {
  ns <- NS(id)
  tagList(
    tags$br(),
    tags$blockquote(
      tags$em(
        tags$h6(
          "The data for this application comes from the ",
          tags$a("ggplot2movies",
            href = "https://github.com/hadley/ggplot2movies"
          ),
          "package"
        )
      )
    ),
    div(
      checkboxInput(
        inputId = ns("missing"),
        label = "Remove missing",
        value = FALSE
      )
    ),
    div(
      plotOutput(outputId = ns("scatterplot"))
      ),
    div(
      verbatimTextOutput(ns("data"))
    )
  )
}

dev_mod_scatter_server <- function(id, rVals, data_fun, con, .dev = FALSE) {
  
  moduleServer(id, function(input, output, session) {
    
    if (.dev) {
      # view output in the UI
      output$data <- renderPrint({
        data_fun
      })
    }

    # use data_fun() function on con
    all_data <- data_fun(con)

    # build reactive data based on missing checkbox input
    graph_data <- reactive({
      if (input$missing) {
        graph_data <- tidyr::drop_na(data = all_data)
      } else {
        graph_data <- all_data
      }
    }) |>
      # bind to input to update when it changes
      bindEvent(input$missing)

    inputs <- reactive({
      plot_title <- tools::toTitleCase(rVals$inputs()[["plot_title"]])
      list(
        x = rVals$inputs()[["x"]],
        y = rVals$inputs()[["y"]],
        z = rVals$inputs()[["z"]],
        alpha = rVals$inputs()[["alpha"]],
        size = rVals$inputs()[["size"]],
        plot_title = plot_title
      )
    })

    observe({
      output$scatterplot <- renderPlot({
        plot <- moviesApp::scatter_plot(
          df = graph_data(),
          x_var = inputs()$x,
          y_var = inputs()$y,
          col_var = inputs()$z,
          alpha_var = inputs()$alpha,
          size_var = inputs()$size
        )
        plot +
          ggplot2::labs(
            title = inputs()$plot_title,
            x = stringr::str_replace_all(
              tools::toTitleCase(inputs()$x), "_", " "
            ),
            y = stringr::str_replace_all(
              tools::toTitleCase(inputs()$y), "_", " "
            )
          ) +
          ggplot2::theme_minimal() +
          ggplot2::theme(legend.position = "bottom")
      })
    }) |>
      # bind this to variable inputs and missing checkbox output
      bindEvent(graph_data(), inputs())
  })
}

devUI <- function() {
  addResourcePath(
    prefix = "dev",
    directoryPath = system.file("dev",
      package = "moviesApp"
    )
  )
  tagList(
    bslib::page_fillable(
      title = "Movie Reviews (ggplot2movies)",
      theme = bslib::bs_theme(
        bg = "#043b67",
        fg = "#ffffff",
        primary = "#ffcf22",
        secondary = "#38B44A",
        success = "#32E0C4",
        base_font = sass::font_google("Ubuntu"),
        heading_font = sass::font_google("Ubuntu")
      ),
      bslib::layout_sidebar(
        sidebar = bslib::sidebar(
          width = 300,
          dev_mod_vars_ui("vars")
        ),
        bslib::card(
          full_screen = TRUE,
          bslib::card_header(
            div(
              img(
                src = "dev/imdb.png",
                height = 40,
                width = 70,
                style = "margin:10px 10px"
              )
            )
          ),
          bslib::card_body(
            fluidRow(
              dev_mod_scatter_ui("plot")
            ),
            fluidRow(
              verbatimTextOutput("vals")
            )
          )
        )
      )
    )
  )
}

devServer <- function(input, output, session) {
  
  # add function to userData
  session$userData$make_dev_ggp2_movies <- make_dev_ggp2_movies
  
  # create reactive values
  rVals <- reactiveValues()
  
  # assign inputs to rVals
  rVals$inputs <- moviesApp::mod_var_input_server("vars", .dev = TRUE)
  
  # view output in the UI
  # output$vals <- renderPrint({
  #   str(session)
  # })

  dev_mod_scatter_server("plot",
    rVals = rVals,
    data_fun = session$userData$make_dev_ggp2_movies, 
    con = "https://bit.ly/3FQYR8j",
    .dev = FALSE
  )
  
}

shinyApp(
  ui = devUI(),
  server = devServer
)
