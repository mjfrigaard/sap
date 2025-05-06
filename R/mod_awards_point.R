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
        width = '100%', height = '70vh')
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
#' 
mod_awards_point_server <- function(id, vals) {
  moduleServer(id, function(input, output, session) {

    output$text_scatter <- shiny::renderPlot({
      shiny::req(vals())

      logr_msg("Creating awards plot with received input values",
        level = "DEBUG")

      tryCatch({
        award <- as.character(vals()$award)
        year <- as.numeric(vals()$year)

        logr_msg(glue::glue("Award: {award}, Year: {year}"),
          level = "DEBUG")

        awards <- get_award_recipients(sap::movies, award, year)
        logr_msg(glue::glue("Created awards dataset with {nrow(awards)} rows"),
          level = "INFO")

        # define year range and award type
        if (award == "picture/director") {
          start_year <- year - 2
          end_year <- year + 2
          label_col <- "director_genre"
        } else {
          start_year <- year - 1
          end_year <- year + 1
          label_col <- "star"
        }

        # jitter points
        pos <- ggplot2::position_jitter(width = 1/100, height = 1/100, seed = 2)

        # create scatter plot
        p <- ggplot2::ggplot(data = awards) +
          ggplot2::aes(
            x = .data$release_year, 
            y = .data$title
            ) +
          ggplot2::geom_point(
            ggplot2::aes(
              color = .data$title
              ),
            position = pos,
            alpha = 1/3,
            size = 1.5,
            show.legend = FALSE
          ) +
          ggplot2::scale_x_continuous(
            breaks = as.integer(
              start_year:end_year
              ),
            labels = scales::label_number(accuracy = 1)
          ) +
          ggplot2::coord_cartesian(clip = "off") +
          ggrepel::geom_label_repel(
            mapping = ggplot2::aes(
              label = .data[[label_col]], 
              fill = .data[[label_col]]),
                color = "#FFFFFF",
                max.iter = 1e5,
                max.time = 1,
                point.padding = 0.5,
                arrow = grid::arrow(
                  length = grid::unit(0.05, "npc"), 
                  type = "closed", 
                  ends = "last"),
                max.overlaps = 35,
                box.padding = 0.60,
                min.segment.length = 3,
                size = 5,
                xlim = c(NA, NA),
                ylim = c(-Inf, Inf),
                show.legend = FALSE
              ) +
          ggplot2::labs(
            x = "Year",
            y = "Awarded Films"
          ) +
          ggplot2::theme(
            legend.position = "none",
            axis.text = ggplot2::element_text(
              color = "#ffffff", size = 14
              ),
            axis.title = ggplot2::element_text(
              color = "#ffffff", size = 16
              )
          )

        logr_msg("Award scatter plot successfully created",
          level = "TRACE")

        print(p)
      }, error = function(e) {
        logr_msg(glue::glue("Error creating award plot: {e$message}"), 
          level = "ERROR")
      })
    })
  })
}

