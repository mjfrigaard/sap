#' User Interface for Horizontal Bar Plot
#'
#' Creates a UI component for displaying a horizontal bar plot visualization.
#' This function is designed to work together with [mod_counts_bar_server()].
#'
#' @param id A character string used to identify the namespace for the module.
#'
#' @return A `tagList` containing a single UI element:
#'   * A plot output area where the horizontal bar chart will be displayed
#'
#' @seealso [mod_counts_bar_server()] for the server-side logic that generates
#'   the horizontal bar plot
#'
#' @examples
#' # UI implementation
#' ui <- fluidPage(
#'   mod_counts_bar_ui("bar1")
#' )
#'
#' # Server implementation
#' server <- function(input, output, session) {
#'   mod_counts_bar_server("bar1", data_reactive())
#' }
#'
#' @export
#'
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
#' @details This function creates a horizontal bar plot showing frequency counts
#'   of a selected categorical variable from the movies dataset, filtered by the
#'   specified year range. It includes proper error handling and logging.
#'
#' @section UI Function:
#'   This server function works with `mod_counts_bar_ui()`.
#'
#' @export
#'
mod_counts_bar_server <- function(id, vals) {
  moduleServer(id, function(input, output, session) {
    logr_msg("Initializing horizontal bar plot module",
      level = "INFO"
    )

    output$hbar_graph <- renderPlot({
      logr_msg("Attempting to render horizontal bar plot",
        level = "TRACE"
      )

      # Validate input values
      req(vals())

      tryCatch({
          # Prepare data for plotting
          logr_msg(glue::glue("Filtering data from {vals()$start_year} to
        {vals()$end_year}"),
            level = "DEBUG"
          )

          x_lab <- name_case(as.character(vals()$chr_var))

          counts_data <- subset(
            movies,
            thtr_rel_year >= vals()$start_year &
              thtr_rel_year <= vals()$end_year
          )

          if (nrow(counts_data) == 0) {
            logr_msg("No data available after filtering by year range",
              level = "WARN"
            )
            return(NULL)
          }

          logr_msg(glue::glue("Creating bar plot with {vals()$chr_var} variable"),
            level = "DEBUG"
          )

          counts_nms <- name_case(names(counts_data))
          counts_data <- setNames(
            object = counts_data,
            nm = counts_nms
          )

          # Create plot
          ggplot2::ggplot(
            counts_data,
            ggplot2::aes(
              x =
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
              ),
              show.legend = FALSE
            ) +
            ggplot2::coord_flip() +
            ggplot2::scale_fill_manual(values = clr_pal12) +
            ggplot2::labs(
              x = NULL,
              y = "# of Movies",
              fill = x_lab
            ) +
            ggplot2::theme(
              legend.position = "none",
              axis.text = ggplot2::element_text(color = "#ffffff", size = 14),
              axis.title = ggplot2::element_text(color = "#ffffff", size = 16)
            )
        },
        error = function(e) {
          logr_msg(glue::glue("Error rendering bar plot: {e$message}"),
            level = "ERROR"
          )
          NULL
        })
    })

    logr_msg("Horizontal bar plot module initialized",
      level = "INFO")
    
    # return reactive output ----
    return(reactive(output$hbar_graph))
  })
}