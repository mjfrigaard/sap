#' User Interface for Ridgeline Plots
#'
#' @param id Shiny module ID.
#'
#' @return A UI for displaying a rain cloud plot.
#' 
#' @section Outputs:
#' - `genre`: Vertical bar plot.
#'
#' @seealso [mod_ridgeline_server()]
#' 
#' @export
#' 
mod_ridgeline_ui <- function(id) {
  ns <- NS(id)
    tagList(
      # verbatimTextOutput(outputId = ns("ridges"))
      plotOutput(outputId = ns("ridges"))
    )
}

#' Server Logic for Raincloud Plot
#'
#' @param id Shiny module ID.
#' @param vals Reactive list of plot parameters.
#'
#' @return Renders a horizontal bar plot based on selected parameters.
#' 
#' @section Reactive Inputs:
#' - `vals`: Reactive list of plot parameters.
#'
#' @seealso [mod_ridgeline_ui()]
#' 
#' @export
mod_ridgeline_server <- function(id, vals) {
  moduleServer(id, function(input, output, session) {

      output$ridges <- renderPlot({
        req(vals())
        d_rl <- subset(moviesApp::movies,
                       !is.na(as.character(vals()$num_var)) &
                       !is.na(as.character(vals()$chr_var)))
        a <- as.numeric(vals()$alpha)
        s <- as.numeric(vals()$size)
        gg2_base <- ggplot2::ggplot(d_rl,
            ggplot2::aes(x = !!vals()$num_var,
                         y = !!vals()$chr_var,
                         fill = !!vals()$chr_var)) +
          ggridges::geom_density_ridges(
                alpha = a,
                # rel_min_height = s/5,
                scale = s/5,
                show.legend = FALSE)
        gg2_base + 
        ggplot2::labs(
          x = title_labs(as.character(vals()$num_var)),
          y = title_labs(as.character(vals()$chr_var))
        ) +
        ggplot2::theme_minimal() +
        ggplot2::theme(legend.position = "none")
      })
  
  })
}