#' Plot Output Module UI
#'
#' UI function for the movie visualization plot module.
#'
#' @param id A character vector used to identify the namespace for this module
#'
#' @return A UI definition for the plot module
#'
#'
#' @export
#' 
plotOutputUI <- function(id) {
  ns <- NS(id)
  bslib::card(
    bslib::card_header("Movie Scatter Plot"),
    bslib::card_body(
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
#' @export
#' 
plotOutputServer <- function(id, data, controls) {
  moduleServer(id, function(input, output, session) {

    output$scatterplot <- renderPlot({
      req(data())
      req(controls())
    
      ctrl <- controls()
      
      # convert to symbols 
      x_var <- rlang::sym(ctrl$x_var)
      y_var <- rlang::sym(ctrl$y_var)
      
      # Create base plot
      p <- ggplot2::ggplot(
                data(), 
              ggplot2::aes(
                # use double bang!!
                  x = !!x_var, 
                  y = !!y_var
                  )
                )
      
      # Add color if selected
      if (ctrl$color_var != "none") {

        # convert to symbols 
        color_var <- rlang::sym(ctrl$color_var)

        p <- p + ggplot2::aes(
                    # use double bang!!
                    color = !!color_var
                  )
      }
      
      # Add points with transparency and size from slider
      p <- p + ggplot2::geom_point(
        alpha = ctrl$alpha, 
        size = ctrl$point_size
      )
      
      # Add labels if requested
      if (ctrl$show_labels) {
        p <- p + ggplot2::geom_text(
          ggplot2::aes(label = title),
          hjust = 0, vjust = 1, 
          size = 3, 
          check_overlap = TRUE
        )
      }
      
      # Add title from text input and theme
      p <- p + 
        ggplot2::labs(
          title = ctrl$plot_title,
          subtitle = paste("Comparing", ctrl$x_var, "vs", ctrl$y_var),
          x = gsub("_", " ", toupper(ctrl$x_var)),
          y = gsub("_", " ", toupper(ctrl$y_var))
        ) +
        ggplot2::theme(
          legend.position = "right",
          plot.title = ggplot2::element_text(face = "bold"),
          plot.subtitle = ggplot2::element_text(face = "italic")
        )
    
      # Return the plot
      p
    })

  })
}
