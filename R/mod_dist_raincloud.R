#' UI for the raincloud plot distribution module
#'
#' Creates a UI component for displaying a raincloud plot - a visualization that
#' combines a half violin plot, boxplot, and jittered dot plot to show
#' distribution characteristics. This function is designed to work together with
#' [mod_dist_raincloud_server()].
#'
#' @param id A character string used to identify the namespace for the module.
#'
#' @return A `tagList` containing UI elements:
#'   * A plot output for the raincloud visualization
#'
#' @seealso [mod_dist_raincloud_server()] for the server-side logic that
#'   generates the raincloud plot
#'
#' @examples
#' # UI implementation
#' ui <- fluidPage(
#'   mod_dist_vars_ui("vars"),
#'   mod_dist_raincloud_ui("raincloud1")
#' )
#'
#' # Server implementation
#' server <- function(input, output, session) {
#'   vals <- mod_dist_vars_server("vars")
#'   mod_dist_raincloud_server("raincloud1", vals = vals)
#' }
#'
mod_dist_raincloud_ui <- function(id) {
  ns <- NS(id)
  tagList(
    plotOutput(outputId = ns("cloud"))
  )
}


#' @title Distribution Raincloud Plot Server Module
#' @description Server-side function for creating raincloud plots to visualize
#'   distributions.
#' @details This module generates a raincloud plot that combines boxplots,
#'   half-eye plots, and jittered points to visualize distributions of a
#'   numeric variable across categories.
#'
#' @section Related UI Function:
#'   Use with `mod_dist_raincloud_ui()`
#'
#' @seealso [mod_dist_raincloud_ui()]
#'
#' @param id Module ID
#' @param vals Reactive expression returning a list with plotting variables:
#'   - num_var: Numeric variable to visualize (x-axis)
#'   - chr_var: Categorical variable for grouping (y-axis)
#'   - alpha: Transparency level for plot elements
#'   - size: Control for density smoothing (higher = smoother)
#'
mod_dist_raincloud_server <- function(id, vals) {
  moduleServer(id, function(input, output, session) {
    output$cloud <- renderPlot(
      {
        req(vals())

        logr_msg("Starting raincloud plot generation", 
          level = "TRACE")

        tryCatch(
          {
            # pretty names
            logr_msg("Formatting movie data column names", 
              level = "DEBUG")
            mv_nms <- names(sap::movies) |> name_case()
            movie_data <- setNames(object = sap::movies, nm = mv_nms)

            a <- as.numeric(vals()$alpha)
            s <- as.numeric(vals()$size)

            logr_msg(glue::glue("Using alpha={a}, size={s} for plot elements"),
              level = "DEBUG"
            )

            # create boxplot layer
            logr_msg("Creating boxplot base layer", 
              level = "DEBUG")
            gg2_box <- ggplot2::ggplot(
              movie_data,
              ggplot2::aes(x = !!vals()$num_var, y = !!vals()$chr_var)
            ) +
              ggplot2::geom_boxplot(
                ggplot2::aes(fill = !!vals()$chr_var),
                width = 0.10,
                outlier.shape = NA,
                alpha = a,
                show.legend = FALSE
              ) +
              ggplot2::scale_fill_manual(values = clr_pal12)

            # add halfeye layer
            logr_msg("Adding halfeye density layer", 
              level = "DEBUG")
            gg2_halfeye <- gg2_box +
              ggdist::stat_halfeye(
                ggplot2::aes(fill = !!vals()$chr_var),
                alpha = a,
                adjust = s / 5,
                .width = 0,
                point_colour = NA,
                orientation = "horizontal",
                height = 0.75,
                justification = -0.20,
                show.legend = FALSE
              )

            # add points layer
            logr_msg("Adding jittered points layer", 
              level = "DEBUG")
            gg2_point <- gg2_halfeye +
              ggplot2::geom_point(
                ggplot2::aes(fill = !!vals()$chr_var),
                position = ggplot2::position_jitter(
                  seed = 54321,
                  height = .05
                ),
                shape = 21,
                color = "#ffffff",
                alpha = a,
                size = 3,
                show.legend = FALSE
              )

            # final plot with formatting
            logr_msg("Applying final formatting to raincloud plot", 
              level = "DEBUG")
            final_plot <- gg2_point +
              ggplot2::labs(
                x = name_case(as.character(vals()$num_var)),
                y = name_case(as.character(vals()$chr_var))
              ) +
              ggplot2::theme(
                legend.position = "none",
                strip.text = ggplot2::element_text(
                  color = "#ffffff", 
                  size = ggplot2::rel(1.05)
                ),
                axis.text = ggplot2::element_text(
                  color = "#ffffff", 
                  size = ggplot2::rel(1.075)
                ),
                axis.title = ggplot2::element_text(
                  color = "#ffffff", 
                  size = ggplot2::rel(1.15)
                )
              )
            logr_msg("Raincloud plot generation complete", 
              level = "INFO")
            return(final_plot)
          },
          error = function(e) {
            logr_msg(glue::glue("Failed to generate raincloud plot: {e$message}"),
              level = "ERROR"
            )

            # return empty plot with error message
            ggplot2::ggplot() +
              ggplot2::annotate("text",
                x = 0, y = 0,
                label = "Error generating plot"
              ) +
              ggplot2::theme_void()
          }
        )
      },
      res = 96
    )
  })
}
