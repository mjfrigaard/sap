#' User Interface for Box Plots
#'
#' @param id Shiny module ID.
#'
#' @return A UI for displaying a box plot.
#' 
#' @section Outputs:
#' - `output$box`: grouped box plot.
#'
#' @seealso [mod_boxplot_server()]
#' 
#' @export
#' 
mod_boxplot_ui <- function(id) {
  ns <- NS(id)
    tagList(
      # verbatimTextOutput(outputId = ns("ridges"))
      plotOutput(outputId = ns("box"))
    )
}

#' Server Logic for Box Plot
#'
#' @param id Shiny module ID.
#' @param vals Reactive list of plot parameters.
#'
#' @return Renders a box plot based on selected parameters.
#' 
#' @section Reactive Inputs:
#' - `vals`: Reactive list of plot parameters.
#'
#' @seealso [mod_boxplot_ui()]
#' 
#' @export
mod_boxplot_server <- function(id, vals) {
  moduleServer(id, function(input, output, session) {

      output$box <- renderPlot({
        req(vals())
        d_bp <- subset(shinyrPkgs::movies,
                       !is.na(as.character(vals()$num_var)) &
                       !is.na(as.character(vals()$chr_var)))
        a <- as.numeric(vals()$alpha)
        s <- as.numeric(vals()$size)
        ggplot2::ggplot(d_bp,
            ggplot2::aes(x = !!vals()$num_var,
                         y = !!vals()$chr_var,
                         fill = !!vals()$chr_var)) +
          ggplot2::geom_boxplot(
                outlier.size = 2.75,
                alpha = a,
                width = s/5,
                show.legend = FALSE) +
        ggplot2::labs(
          x = name_case(as.character(vals()$num_var)),
          y = name_case(as.character(vals()$chr_var))
        ) +
        ggplot2::theme_minimal() +
        ggplot2::theme(legend.position = "none")
      })
  
  })
}
