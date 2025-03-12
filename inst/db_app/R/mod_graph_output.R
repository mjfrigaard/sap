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