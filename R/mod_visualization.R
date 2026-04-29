#' Visualization Module UI
#'
#' @param id Module namespace
#' @return Shiny UI element
mod_visualization_ui <- function(id) {
  ns <- NS(id)
  card(
    card_header("Movies Visualization"),
    card_body(
      plotOutput(ns("scatter_plot"))
    )
  )
}

#' Visualization Module Server
#'
#' @param id Module namespace
#' @param data Reactive data
#' @param inputs List of reactive inputs from inputs module
#' 
#' @return Reactive plot object
#' 
mod_visualization_server <- function(id, data, inputs) {
  moduleServer(id, function(input, output, session) {
    
    plot_reactive <- reactive({
      req(data(), inputs$x_var(), inputs$y_var(), inputs$col_var(),
          inputs$alpha_var(), inputs$size_var())

      df <- data()
      if (!is.null(inputs$genre_filter()) && inputs$genre_filter() != "All") {
        df <- df[df$genre == inputs$genre_filter(), ]
      }

      scatter_plot(
        df = df,
        x_var = inputs$x_var(),
        y_var = inputs$y_var(),
        col_var = inputs$col_var(),
        alpha_var = inputs$alpha_var(),
        size_var = inputs$size_var()
      ) +
        theme_minimal() +
        labs(
          title = paste("Movies:", inputs$x_var(), "vs", inputs$y_var()),
          x = tools::toTitleCase(gsub("_", " ", inputs$x_var())),
          y = tools::toTitleCase(gsub("_", " ", inputs$y_var()))
        ) +
        theme(legend.position = "bottom")
    })
    
    output$scatter_plot <- renderPlot({
      plot_reactive()
    })
    
    return(list(
      plot = plot_reactive
    ))
  })
}