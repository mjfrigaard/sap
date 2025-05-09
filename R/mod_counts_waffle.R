#' UI for counts waffle plot module
#'
#' Creates a container for displaying a waffle chart visualization. This 
#' function is designed to work together with [mod_counts_waffle_server()].
#'
#' @param id A character string used to identify the namespace for the module.
#'
#' @return A `tagList` containing UI elements:
#'   * A plot output area that will display the waffle chart
#'
#' @seealso [mod_counts_waffle_server()] for the server-side logic that generates
#'   the waffle chart visualization
#'
#' @examples
#' # UI implementation
#' ui <- fluidPage(
#'   mod_counts_waffle_ui("waffle1")
#' )
#'
#' # Server implementation
#' server <- function(input, output, session) {
#'   mod_counts_waffle_server("waffle1", counts_data = reactive(data))
#' }
#'
#' @export
#' 
mod_counts_waffle_ui <- function(id) {
  ns <- NS(id)
    tagList(
      plotOutput(outputId = ns("waffle_plot"))
    )
}

#' Server Logic for Vertical Bar Plot
#'
#' @param id Shiny module ID.
#' @param vals Reactive list of plot parameters.
#'
#' @return Renders a vertical bar plot based on selected parameters.
#'
#' @details This server function creates a waffle plot visualization using
#'   the movie dataset. It filters data based on selected years and creates
#'   a waffle chart representation of the selected categorical variable.
#'
#' @section Log Messages:
#'   Contains logging for errors and tracking critical rendering steps.
#'
#' @seealso [mod_counts_waffle_ui()]
#' 
#' @export
#' 
mod_counts_waffle_server <- function(id, vals) {
  moduleServer(id, function(input, output, session) {
    
    output$waffle_plot <- renderPlot({
      logr_msg("Starting waffle plot rendering", 
        level = "TRACE")
      
      req(vals())
      
      tryCatch({
        # Get parameters from inputs
        x_lab <- name_case(as.character(vals()$chr_var))
        movies <- sap::movies
        
        logr_msg(glue::glue("Filtering data from {vals()$start_year} to 
        {vals()$end_year}"),
          level = "DEBUG")
        
        # Subset data based on year range
        waffle_set <- subset(movies, 
          thtr_rel_year >= vals()$start_year &
          thtr_rel_year <= vals()$end_year)
          
          if (nrow(waffle_set) == 0) {
            logr_msg("No data available for selected year range", 
              level = "WARN")
          }
          
          # Clean names 
          nms_set <- names(waffle_set) |> name_case()
          movie_vars <- setNames(object = waffle_set, nm = nms_set)
          movie_vars$chr_var <- as.character(movie_vars[[vals()$chr_var]])
          
          logr_msg(glue::glue("Creating waffle plot for {vals()$chr_var}"), 
          level = "DEBUG")
          
          # Create waffle iron data structure
          movies_iron <- ggwaffle::waffle_iron(movie_vars,
            ggwaffle::aes_d(group = chr_var))
            
            # Build plot
            ggplot2::ggplot(data = movies_iron, 
              ggplot2::aes(x = x, 
                y = y, 
                fill = group)) + 
                ggwaffle::geom_waffle() +
                ggplot2::scale_fill_manual(values = clr_pal12) +  
                ggplot2::labs(
                  x = "", y = "", 
                  fill = x_lab
                ) + 
                ggwaffle::theme_waffle() +
                ggplot2::theme( 
                  legend.text = ggplot2::element_text(
                    color = "#ffffff", size = 14),
                  legend.title = ggplot2::element_text(
                    color = "#ffffff", size = 16)
                )
                
              }, error = function(e) {
                logr_msg(glue::glue("Failed to render waffle plot: {e$message}"), 
                level = "ERROR")
                
                # Return an empty plot with error message
                ggplot2::ggplot() + 
                ggplot2::annotate("text", x = 0, y = 0, 
                label = "Error creating waffle plot") +
                ggplot2::theme_minimal()
            })
        })
    })
}