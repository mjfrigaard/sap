#' User Interface for Scatter Plot Text Repel
#'
#' @param id Shiny module ID.
#'
#' @return A UI for displaying a scatter plot.
#' 
#' @section Outputs:
#' - `scatter`: Scatter plot.
#'
#' @seealso [mod_awards_point_server()], [mod_awards_vars_server()], [mod_awards_vars_ui()]
#' 
#' @export
mod_awards_point_ui <- function(id) {
  ns <- NS(id)
  tagList(
    plotOutput(ns("text_scatter"),
      width = '100%', height = '100%')
    )
}

#' Server Logic for Scatter Plot Text Repel
#'
#' @param id Shiny module ID.
#' @param vals Reactive list of plot parameters.
#'
#' @return Renders a scatter plot based on selected parameters.
#' 
#' @section Reactive Inputs:
#' - `vals`: Reactive list of plot parameters.
#'
#' @seealso [mod_awards_point_ui()], [mod_awards_vars_server()], [mod_awards_vars_ui()]
#' 
#' @export
#' 
mod_awards_point_server <- function(id, vals) {
  moduleServer(id, function(input, output, session) {
    
    output$text_scatter <- renderPlot({
      req(vals())
      awards <- create_movie_awards(award = as.character(vals()$award),
                                    start_year = as.numeric(vals()$start_year),
                                    end_year = as.numeric(vals()$end_year))
      # standalone values
      start_year <- as.numeric(vals()$start_year)
      end_year <- as.numeric(vals()$end_year)
      # position
      pos <- ggplot2::position_jitter(width = 1/100, height = 1/100, seed = 2)
      
      p <- ggplot2::ggplot(data = awards) + 
            ggplot2::aes(x = year,  
                        y = award, 
                        label = title) + 
            ggplot2::geom_point(
              ggplot2::aes(color = title), 
                position = pos, 
                alpha = 1/3, 
                size = 1.5, 
                show.legend = FALSE) + 
            ggplot2::scale_x_continuous( 
             breaks = as.integer(start_year:end_year), 
             labels = scales::label_number(accuracy = 1)) + 
            ggplot2::coord_cartesian(clip = "off") +
            ggrepel::geom_label_repel(
              mapping = ggplot2::aes(fill = title),
                    # color = "#FFFFFF",
                    max.iter = 1e5,
                    max.time = 1,
                    point.padding = 0.5,
                    arrow = grid::arrow(
                          length = grid::unit(0.02, "npc"), 
                          type = "closed", 
                          ends = "last"),
                    max.overlaps = 500,
                    box.padding = 0.85,
                    min.segment.length = 0,
                    size = 6,
                    xlim = c(NA, NA),
                    ylim = c(NA, Inf),
                    show.legend = FALSE,
              ) +
          ggplot2::labs(
            x = name_case("year"), 
            y = name_case("awards")
            ) +
          ggplot2::theme(
            legend.position = "none",
          # plot.background = ggplot2::element_rect(fill = "#121212", color = NA),
          # panel.background = ggplot2::element_rect(fill = "#121212", color = NA),
          # panel.grid.major = ggplot2::element_line(color = "#ffffff"),
          # panel.grid.minor = ggplot2::element_line(color = "#ffffff"),
          # axis.ticks = ggplot2::element_line(color = "#ffffff"),
            axis.text = ggplot2::element_text(color = "#ffffff", size = 14),
            axis.title = ggplot2::element_text(color = "#ffffff", size = 16)
          )
      print(p)
    })
    
  })
}
