options(scipen = 100000000)

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
        "Rating" = "avg_rating",
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
        "Rating" = "avg_rating",
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
    )
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
    tags$div(
      checkboxInput(
        inputId = ns("missing"),
        label = "Remove missing",
        value = TRUE
      ),
      plotOutput(outputId = ns("scatterplot"))
    )
  )
}

dev_mod_scatter_server <- function(id, var_inputs) {
  moduleServer(id, function(input, output, session) {
    
  observe({
     browser()
    

    # load alternate data
    all_data <- fst::read_fst("tidy_movies.fst")

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
      plot_title <- tools::toTitleCase(var_inputs()$plot_title)
      list(
        x = var_inputs()$x,
        y = var_inputs()$y,
        z = var_inputs()$z,
        alpha = var_inputs()$alpha,
        size = var_inputs()$size,
        plot_title = plot_title
      )
    })

    observe({
        output$scatterplot <- renderPlot({
          plot <- sap::scatter_plot(
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
                      tools::toTitleCase(inputs()$x), "_", " "),
              y = stringr::str_replace_all(
                      tools::toTitleCase(inputs()$y), "_", " ")
            ) +
            ggplot2::theme_minimal() +
            ggplot2::theme(legend.position = "bottom")
        })
    }) |>
      # bind this to variable inputs and missing checkbox output
      bindEvent(graph_data(), inputs())
    
    })
  })
}

devUI <- function() {
    addResourcePath(
      prefix = "dev",
      directoryPath = system.file("dev", 
                                  package = "sap")
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
          dev_mod_vars_ui("vars")
        ),
        bslib::card(
          full_screen = TRUE,
          bslib::card_header(
              tags$div(
                tags$img(
                  src = "dev/imdb.png",
                  height = 80,
                  width = 110,
                  style = "margin:10px 10px"
                )
              )
            ),
          bslib::card_body(
            dev_mod_scatter_ui("plot")
          )
        )
      )
    )
  )
}

devServer <- function(input, output, session) {
  
  selected_vars <- sap::mod_var_input_server("vars")

  dev_mod_scatter_server("plot", var_inputs = selected_vars)
  
}

shinyApp(
  ui = devUI(),
  server = devServer
)
