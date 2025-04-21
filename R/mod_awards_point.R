#' Point-based scatter plot UI for awards data
#'
#' Creates a plot output area for displaying the point-based scatter plot
#' of awards data. This function is designed to work together with 
#' [mod_awards_point_server()].
#'
#' @param id A character string used to identify the namespace for the module.
#'
#' @return A `tagList` containing a single UI element:
#'   * A plot output that displays the awards scatter plot
#'
#' @seealso [mod_awards_point_server()] for the server-side logic that generates
#'   the plot
#'
#' @examples
#' # UI implementation
#' ui <- fluidPage(
#'   mod_awards_point_ui("awards_plot")
#' )
#'
#' # Server implementation
#' server <- function(input, output, session) {
#'   mod_awards_point_server("awards_plot", data_reactive())
#' }
#'
mod_awards_point_ui <- function(id) {
  ns <- NS(id)
  tagList(
    plotOutput(ns("text_scatter"),
      width = '100%', height = '100%')
    )
}

#' Server function for displaying movie awards scatter plot
#' 
#' Takes award selections and date range inputs to create a scatter plot showing
#' movie awards over time. Each point represents a movie that won a specific
#' award, with labels for movie titles using ggrepel.
#' 
#' @param id A character. The ID namespace for the module
#' @param vals A reactive. Contains award selection, start_year, and end_year
#' 
#' @return Renders a scatter plot.
#' 
#' @seealso [mod_awards_point_ui()]
#' 
#' @export
mod_awards_point_server <- function(id, vals) {
  moduleServer(id, function(input, output, session) {
    
    output$text_scatter <- renderPlot({
      # Require reactive values before proceeding
      req(vals())
      
      logr_msg("Creating awards plot with received input values", level = "DEBUG")
      
      tryCatch({
        # Extract input parameters
        award <- as.character(vals()$award)
        start_year <- as.numeric(vals()$start_year)
        end_year <- as.numeric(vals()$end_year)
        
        logr_msg(glue::glue("Award: {award}, Years: {start_year}-{end_year}"), 
          level = "DEBUG")
        
        # Generate the awards dataset
        awards <- create_movie_awards(
          df = sap::movies,
          award = award,
          start_year = start_year,
          end_year = end_year
        )
        
        logr_msg(glue::glue("Created awards dataset with {nrow(awards)} rows"), 
          level = "INFO")
        
        # Set jitter position for better point visualization
        pos <- ggplot2::position_jitter(width = 1/100, height = 1/100, seed = 2)
        
        # Create scatter plot with repel labels
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
            axis.text = ggplot2::element_text(color = "#ffffff", size = 14),
            axis.title = ggplot2::element_text(color = "#ffffff", size = 16)
          )
        
        logr_msg("Award scatter plot successfully created", level = "TRACE")
        
        print(p)
      }, error = function(e) {
        logr_msg(glue::glue("Error creating award plot: {e$message}"), 
          level = "ERROR")
      })
    })
  })
}
