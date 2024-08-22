#' User Interface for Horizontal Bar Plot
#'
#' @param id Shiny module ID.
#'
#' @return A UI for displaying a horizontal bar plot.
#' 
#' @section Outputs:
#' - `hbar_graph`: Horizontal bar plot.
#'
#' @seealso [mod_counts_bar_server()]
#' 
#' @export
mod_counts_bar_ui <- function(id) {
  ns <- NS(id)
    tagList(
      plotOutput(outputId = ns("hbar_graph"))
    )
}

#' Server Logic for Horizontal Bar Plot
#'
#' @param id Shiny module ID.
#' @param vals Reactive list of plot parameters.
#'
#' @return Renders a horizontal bar plot based on selected parameters.
#' 
#' @section Reactive Inputs:
#' - `vals`: Reactive list of plot parameters.
#'
#' @seealso [mod_counts_bar_ui()]
#' 
#' @export
mod_counts_bar_server <- function(id, vals) {
  moduleServer(id, function(input, output, session) {
        
      output$hbar_graph <- renderPlot({
      req(vals())
      x_lab <- name_case(as.character(vals()$chr_var))
      d <- subset(movies, 
        thtr_rel_year >= vals()$start_year &
        thtr_rel_year <= vals()$end_year)
      ggplot2::ggplot(d,
        ggplot2::aes(x = 
            forcats::fct_rev(
              forcats::fct_infreq(
                !!vals()$chr_var
              )
            )
          )
        ) +
        ggplot2::geom_bar(
          ggplot2::aes(
            fill = !!vals()$chr_var
          ), show.legend = FALSE
        ) +
        ggplot2::coord_flip() + 
        ggplot2::scale_fill_manual(values = clr_pal12) +  
        ggplot2::labs(
          x = x_lab,
          y = "# of Movies", 
          fill = x_lab
        ) +
        ggplot2::theme(
              legend.position = "none",
              axis.text = ggplot2::element_text(color = "#ffffff", size = 14),
              axis.title = ggplot2::element_text(color = "#ffffff", size = 16)
            )
    })
  
  })
}
