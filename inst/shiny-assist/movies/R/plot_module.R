#' Plot Output Module UI
#'
#' UI function for the movie visualization plot module.
#'
#' @param id A character vector used to identify the namespace for this module
#'
#' @return A UI definition for the plot module
#'
#' @importFrom shiny NS plotOutput
#' @importFrom bslib card card_header card_body
#'
#' @export
plotOutputUI <- function(id) {
  ns <- NS(id)
  card(
    card_header("Movie Scatter Plot"),
    card_body(
      plotOutput(ns("scatterplot"), height = "600px")
    )
  )
}

#' Plot Output Module Server
#'
#' Server function for the movie visualization plot module.
#'
#' @param id A character vector used to identify the namespace for this module
#' @param data A reactive expression returning the data to be plotted
#' @param controls A reactive expression returning the control values
#'
#' @return None
#'
#' @importFrom shiny moduleServer renderPlot req
#' @importFrom ggplot2 ggplot aes_string geom_point geom_text labs theme_minimal theme element_text
#'
#' @export
plotOutputServer <- function(id, data, controls) {
  moduleServer(id, function(input, output, session) {
    output$scatterplot <- renderPlot({
      req(data())
      req(controls())
      
      ctrl <- controls()
      
      # Create base plot
      p <- ggplot(data(), aes_string(x = ctrl$x_var, y = ctrl$y_var))
      
      # Add color if selected
      if (ctrl$color_var != "none") {
        p <- p + aes_string(color = ctrl$color_var)
      }
      
      # Add points with transparency and size from slider
      p <- p + geom_point(alpha = ctrl$alpha, size = ctrl$point_size)
      
      # Add labels if requested
      if (ctrl$show_labels) {
        p <- p + geom_text(aes(label = title), 
                           hjust = 0, vjust = 1, 
                           size = 3, 
                           check_overlap = TRUE)
      }
      
      # Add title from text input and theme
      p <- p + 
        labs(
          title = ctrl$plot_title,
          subtitle = paste("Comparing", ctrl$x_var, "vs", ctrl$y_var),
          x = gsub("_", " ", toupper(ctrl$x_var)),
          y = gsub("_", " ", toupper(ctrl$y_var))
        )
      
      # Theme is handled by thematic, so we don't need to add theme_minimal()
      # Just add any specific theme modifications
      p <- p + theme(
        legend.position = "right",
        plot.title = element_text(face = "bold"),
        plot.subtitle = element_text(face = "italic")
      )
      
      # Return the plot
      p
    })
  })
}
