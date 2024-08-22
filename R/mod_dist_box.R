#' User Interface for Box Plots
#'
#' @param id Shiny module ID.
#'
#' @return A UI for displaying a box plot.
#' 
#' @section Outputs:
#' - `output$box`: grouped box plot.
#'
#' @seealso [mod_dist_box_server()]
#' 
#' @export
#' 
mod_dist_box_ui <- function(id) {
  ns <- NS(id)
    tagList(
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
#' @seealso [mod_dist_box_ui()]
#' 
#' @export
mod_dist_box_server <- function(id, vals) {
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
          show.legend = FALSE
        ) +
        ggplot2::scale_fill_manual(values = clr_pal12) +
        ggplot2::labs(
          x = name_case(as.character(vals()$num_var)),
          y = name_case(as.character(vals()$chr_var))
        ) +
        # ggplot2::theme_void(base_size = 16) + 
        ggplot2::theme(
          legend.position = "none",
          # plot.background = ggplot2::element_rect(fill = "#121212", color = NA),
          # panel.background = ggplot2::element_rect(fill = "#121212", color = NA),
          # panel.grid.major = ggplot2::element_line(color = "#ffffff"),
          # panel.grid.minor = ggplot2::element_line(color = "#ffffff"),
          # axis.ticks = ggplot2::element_line(color = "#ffffff"),
          axis.text = ggplot2::element_text(color = "#ffffff", size = 14),
          axis.title = ggplot2::element_text(color = "#ffffff", size = 16),

      )
    })

  
  })
}
