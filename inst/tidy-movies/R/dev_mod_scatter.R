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

dev_mod_scatter_server <- function(id, var_inputs, aes_inputs) {
  moduleServer(id, function(input, output, session) {

    # load alternate data
    all_data <- tryCatch({
      log_message(
        message = "Loading fst data", 
        log_file = "_logs/ggp2_log.txt",
        save = TRUE)
      fst::read_fst("tidy_movies.fst")
    }, error = function(e) {
      log_message(
        message = sprintf("Error loading fst data: %s", e$message), 
        log_file = "_logs/ggp2_log.txt", 
        save = TRUE)
      stop("Data loading failed.")
    })

    graph_data <- reactive({
      tryCatch({
        if (input$missing) {
          log_message("Removing missing values.", 
                      log_file = "_logs/ggp2_log.txt",
                      save = TRUE)
          graph_data <- tidyr::drop_na(data = all_data)
        } else {
          log_message("Using all data.", 
                      log_file = "_logs/ggp2_log.txt",
                      save = TRUE)
          graph_data <- all_data
        }
        graph_data
      }, error = function(e) {
        log_message(
          sprintf("Error processing graph data: %s", e$message), 
          log_file = "_logs/ggp2_log.txt",
          save = TRUE
        )
        NULL
      })
    }) |> bindEvent(input$missing)

    inputs <- reactive({
      tryCatch({
        plot_title <- tools::toTitleCase(aes_inputs()$plot_title)
        log_message(
          sprintf("Processing plot title: '%s'", plot_title), 
          log_file = "_logs/ggp2_log.txt", 
          save = TRUE)
    
        input_list <- list(
          x = var_inputs()$x,
          y = var_inputs()$y,
          z = var_inputs()$z,
          alpha = aes_inputs()$alpha,
          size = aes_inputs()$size,
          plot_title = plot_title
        )
        log_message(
          sprintf("Inputs constructed: %s", 
                  paste(names(input_list), input_list, sep = "=", collapse = ", ")
                ),
                log_file = "_logs/ggp2_log.txt",
                save = TRUE)
    
        input_list
      }, error = function(e) {
        log_message(
          sprintf("Error in processing inputs: %s", conditionMessage(e)),
          log_file = "_logs/ggp2_log.txt",
          save = TRUE)
        NULL  
      })
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
}
