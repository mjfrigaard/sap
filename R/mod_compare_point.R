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
      width = '100%', height = '100%')
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
    
    logr_msg("Initializing point comparison module", level = "DEBUG")
    
    label_inputs <- reactive({
      req(vals()$x, vals()$y, vals()$c)
      
      logr_msg(glue::glue("Setting up labels with x={vals()$x}, y={vals()$y},",
        " color={vals()$color}"), level = "TRACE")
      
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
      
      logr_msg("Preparing to render scatter plot", level = "DEBUG")
      
      tryCatch({
        # clean names
        nms <- name_case(names(movies))
        compare_data <- stats::setNames(object = movies, nm = nms)
        
        logr_msg(glue::glue("Creating plot with {nrow(compare_data)} data points"), 
          level = "INFO")
        
        if (nrow(compare_data) > 5000) {
          logr_msg("Large dataset detected - rendering may be slow", 
            level = "WARN")
        }
        
        plot <- plotly::plot_ly(
          data = compare_data,
          x = ~get(vals()$x),
          y = ~get(vals()$y),
          color = ~get(vals()$color),
          text = ~title,
          type = 'scatter',
          mode = 'markers',
          colors = clr_pal3,
          marker = list(
            size = vals()$size,
            opacity = vals()$alpha
          )
        ) |>
          plotly::layout(
            title = list(
              text = label_inputs()$title,
              font = list(color = "#e0e0e0")  
            ),
            xaxis = list(
              title = label_inputs()$x,
              titlefont = list(color = "#e0e0e0"),  
              tickfont = list(color = "#e0e0e0")   
            ),
            yaxis = list(
              title = label_inputs()$y,
              titlefont = list(color = "#e0e0e0"),  
              tickfont = list(color = "#e0e0e0")   
            ),
            legend = list(
              font = list(color = "#e0e0e0")        
            ),
            plot_bgcolor = "#121212",    
            paper_bgcolor = "#121212"    
          )
        
        logr_msg("Scatter plot rendered successfully", level = "DEBUG")
        return(plot)
        
      }, error = function(e) {
        logr_msg(glue::glue("Failed to render scatter plot: {e$message}"), 
          level = "ERROR")
        
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
    
    # Log when module is disposed (session ends)
    session$onSessionEnded(function() {
      logr_msg("Point comparison module session ended", level = "INFO")
    })
  })
}