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
          plot <- shinyAppPkgs::scatter_plot(
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
}
