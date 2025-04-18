#' User Interface for Scatter Plot
#'
#' @param id Shiny module ID.
#'
#' @return UI for displaying a scatter plot.
#' 
#' @export
mod_compare_point_ui <- function(id) {
  ns <- NS(id)
  tagList(
    plotly::plotlyOutput(ns("scatter"),
      width = '100%', height = '100%')
  )
}

#' Server Logic for Scatter Plot
#'
#' @param id Shiny module ID.
#' @param vals Reactive list of plot parameters.
#'
#' @return Renders a scatter plot based on selected parameters.
#' 
#' @details This server function renders a scatter plot using plotly based on
#'   user-selected variables. It includes logging at different levels to track
#'   execution and potential errors.
#'
#' @seealso [mod_compare_point_ui()]
#' 
#' @export
#' 
mod_compare_point_server <- function(id, vals) {
  moduleServer(id, function(input, output, session) {
    
    logr_msg("Initializing scatter plot module server", level = "INFO")
    
    label_inputs <- reactive({
      logr_msg("Building label inputs", level = "TRACE")
      
      req(vals()$x, vals()$y, vals()$c)
      
      logr_msg(
        glue::glue("Processing inputs: x={vals()$x}, y={vals()$y}, 
        color={vals()$color}"),
        level = "DEBUG"
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
      logr_msg("Rendering scatter plot", level = "TRACE")
      
      req(vals())
      
      if(is.null(vals()$size) || is.null(vals()$alpha)) {
        logr_msg("Missing size or alpha parameter", level = "WARN")
      }
      
      tryCatch({
        # clean names
        nms <- name_case(names(movies))
        compare_data <- stats::setNames(object = movies, nm = nms)
        
        logr_msg(
          glue::glue("Creating plot with {nrow(compare_data)} data points"),
          level = "DEBUG"
        )
        
        plotly::plot_ly(
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
      }, error = function(e) {
        logr_msg(
          glue::glue("Failed to render scatter plot: {e$message}"), 
          level = "ERROR"
        )
        
        # Return empty plot with error message
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
    
    logr_msg("Scatter plot module server initialized", level = "INFO")
    
  })
}