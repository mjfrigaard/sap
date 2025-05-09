#' UI for distribution box plot module
#'
#' Creates the UI component for displaying a box plot visualization. This
#' function is designed to work together with [mod_dist_box_server()].
#'
#' @param id A character string used to identify the namespace for the module.
#'
#' @return A `tagList` containing UI elements:
#'   * A plot output area for the box plot visualization
#'
#' @seealso [mod_dist_box_server()] for the server-side logic
#'
#' @examples
#' # UI implementation
#' ui <- fluidPage(
#'   mod_dist_box_ui("dist_box1")
#' )
#'
#' # Server implementation
#' server <- function(input, output, session) {
#'   mod_dist_box_server("dist_box1", data_reactive())
#' }
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
#' @details This server function generates a box plot visualization using the
#'   provided parameters in the reactive 'vals' list. It properly handles missing
#'   values and applies aesthetic parameters like alpha and size.
#'
#' @section Associated UI Function:
#'   This server function should be used with the corresponding UI function
#'   `mod_dist_box_ui()`.
#'
#' @export
#'
mod_dist_box_server <- function(id, vals) {
  moduleServer(id, function(input, output, session) {
    output$box <- renderPlot(
      {
        req(vals())

        logr_msg("Preparing box plot in mod_dist_box_server", 
          level = "TRACE")

        tryCatch(
          {
            # pretty names
            mv_nms <- names(sap::movies) |> name_case()
            movie_data <- setNames(object = sap::movies, nm = mv_nms)

            logr_msg(glue::glue("Processing data with {nrow(movie_data)} rows"),
              level = "DEBUG"
            )

            d_bp <- subset(
              movie_data,
              !is.na(as.character(vals()$num_var)) &
                !is.na(as.character(vals()$chr_var))
            )

            # log warning if significant data filtering occurred
            if (nrow(d_bp) < nrow(movie_data) * 0.7) {
              logr_msg(glue::glue("Significant data loss: {nrow(movie_data) -
                          nrow(d_bp)} rows removed due to NA values"), 
                level = "WARN")
            }

            a <- as.numeric(vals()$alpha)
            s <- as.numeric(vals()$size)

            logr_msg(glue::glue("Creating box plot with {vals()$num_var} and
                        {vals()$chr_var}"), 
                     level = "DEBUG")

            ggplot2::ggplot(
              d_bp,
              ggplot2::aes(
                x = !!vals()$num_var,
                y = !!vals()$chr_var,
                fill = !!vals()$chr_var
              )
            ) +
              ggplot2::geom_boxplot(
                outlier.size = 2.75,
                alpha = a,
                width = s / 5,
                show.legend = FALSE
              ) +
              ggplot2::scale_fill_manual(values = clr_pal12) +
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
                ),
                plot.background = ggplot2::element_rect(
                  fill = "transparent",
                  color = NA
                )
              )
          },
          error = function(e) {
            logr_msg(glue::glue("Failed to render box plot: {e$message}"),
              level = "ERROR"
            )
            # return a blank plot with error message
            ggplot2::ggplot() +
              ggplot2::annotate("text",
                x = 0, y = 0,
                label = "Error rendering plot",
                color = "red", size = 6
              ) +
              ggplot2::theme_void()
          }
        )
      },
      res = 96
    )
  })
}
