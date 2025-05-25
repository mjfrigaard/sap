#' UI for comparison point chart module
#'
#' Creates a plotly scatterplot visualization for comparing two variables.
#' This function is designed to work together with [mod_compare_point_server()].
#'
#' @seealso [mod_compare_point_server()]
#'
#' @param id A character string used to identify the namespace for the module.
#'
#' @return A `tagList` containing a single UI element:
#'   * A responsive plotly scatterplot that fills its container (100% width
#'   and height)
#'
#' @seealso [mod_compare_point_server()] for the server-side logic
#'
#' @examples
#' # UI implementation
#' ui <- fluidPage(
#'   mod_compare_point_ui("compare1")
#' )
#'
#' # Server implementation
#' server <- function(input, output, session) {
#'   mod_compare_point_server("compare1", data_r, selected_vars_r)
#' }
#'
mod_compare_point_ui <- function(id) {
  ns <- NS(id)
  tagList(
    plotly::plotlyOutput(ns("scatter"),
      width = "100%", height = "100%"
    )
  )
}

#' Server Logic for Scatter Plot
#'
#' This server function renders a scatter plot using plotly based on
#' user-selected variables
#'
#' @param id Shiny module ID.
#' @param vals Reactive list of plot parameters.
#'
#' @return Renders a scatter plot based on selected parameters.
#'
#' @details It includes logging at different levels to track execution
#'    and potential errors.
#'
#' @seealso [mod_compare_point_ui()]
#'
#' @export
#'
mod_compare_point_server <- function(id, vals) {
  moduleServer(id, function(input, output, session) {
    logr_msg("Initializing point comparison module",
      level = "DEBUG"
    )

    label_inputs <- reactive({
      req(vals()$x, vals()$y, vals()$c)

      logr_msg(
        glue::glue(
          "Setting up labels with x={vals()$x}, y={vals()$y},",
          " color={vals()$color}"
        ),
        level = "TRACE"
      )

      list(
        x = name_case(as.character(vals()$x)),
        y = name_case(as.character(vals()$y)),
        color = name_case(as.character(vals()$color)),
        title = name_case(as.character(vals()$title)),
        subtitle = paste(
          name_case(as.character(vals()$x)),
          "vs.", name_case(as.character(vals()$y)),
          "and", name_case(as.character(vals()$c))
        )
      )
    })

    
      
    output$scatter <- plotly::renderPlotly({
      req(label_inputs())

      logr_msg("Preparing to render scatter plot",
        level = "DEBUG"
      )

      tryCatch({
          # create data 
          compare_data <- sap::movies
          # variables
          x_var <- name_case(as.character(vals()$x), case = "lower")
          y_var <- name_case(as.character(vals()$y), case = "lower")
          color_var <- name_case(as.character(vals()$color), case = "lower")
          title <- name_case(as.character(vals()$title), case = "lower")
          # aesthetics 
          size <- as.numeric(vals()$size)
          alpha <- as.numeric(vals()$alpha)

          logr_msg(glue::glue("Creating plot with {nrow(compare_data)} data points"),
            level = "INFO"
          )

          if (nrow(compare_data) > 5000) {
            logr_msg("Large dataset detected - rendering may be slow",
              level = "WARN"
            )
          }
          
          plot <- compare_plot(data = compare_data, 
                               x = x_var, y = y_var, color = color_var, 
                               size = size, alpha = alpha, 
                               title = title)

          logr_msg("Scatter plot rendered successfully",
            level = "DEBUG"
          )
          return(plot)
        },
        error = function(e) {
          logr_msg(glue::glue("Failed to render scatter plot: {e$message}"),
            level = "ERROR"
          )
          # Return minimal error plot
          plotly::plot_ly() |>
            plotly::add_annotations(
              text = "Error rendering plot. Please check your selections.",
              showarrow = FALSE,
              font = list(color = "#e0e0e0")
            ) |>
            plotly::layout(
              plot_bgcolor = "#121212",
              paper_bgcolor = "#121212"
              )
          })
    })

    # log when module is disposed (session ends)
    session$onSessionEnded(function() {
      logr_msg("Point comparison module session ended",
        level = "INFO"
      )
    })
  })
}