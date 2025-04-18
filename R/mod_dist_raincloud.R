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

#' Server Logic for Raincloud Plot
#'
#' @param id Shiny module ID.
#' @param vals Reactive list of plot parameters.
#'
#' @return Renders a raincloud plot visualizing distribution of numeric data
#'   grouped by a categorical variable.
#' 
#' @details
#' This server function creates a raincloud plot combining boxplot, half-eye
#' density, and jittered points to show data distributions. The plot helps
#' visualize both the raw data points and their statistical properties.
#'
#' @section Logging:
#' The function implements comprehensive logging at various levels:
#' - TRACE for tracking rendering process
#' - INFO for successful plot creation
#' - DEBUG for parameter diagnostics
#' - ERROR for handled exceptions
#'
#' @seealso [mod_dist_raincloud_ui()]
#' 
#' @export
#' 
mod_dist_raincloud_server <- function(id, vals) {
  moduleServer(id, function(input, output, session) {
    
    logr_msg("Initializing raincloud plot module", level = "TRACE")
    
    output$cloud <- renderPlot({
      
      logr_msg("Starting raincloud plot rendering", level = "TRACE")
      
      req(vals())
      
      tryCatch({
        # Log input parameters for debugging
        logr_msg(
          paste0("Raincloud plot parameters - num_var: ", vals()$num_var, 
          ", chr_var: ", vals()$chr_var,
          ", alpha: ", vals()$alpha,
          ", size: ", vals()$size),
          level = "DEBUG"
        )
        
        # Pretty names 
        mv_nms <- names(sap::movies) |> name_case()
        movie_data <- setNames(object = sap::movies, nm = mv_nms)
        
        a <- as.numeric(vals()$alpha)
        s <- as.numeric(vals()$size)
        
        # Create boxplot layer
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
        
        logr_msg("Boxplot layer created", level = "TRACE")
        
        # Add halfeye layer
        gg2_halfeye <- gg2_box +
        ggdist::stat_halfeye(
          ggplot2::aes(fill = !!vals()$chr_var),
          alpha = a,
          adjust = s/5, 
          .width = 0, 
          point_colour = NA, 
          orientation = "horizontal", 
          height = 0.75, 
          justification = -0.20, 
          show.legend = FALSE 
        )
        
        logr_msg("Halfeye density layer added", level = "TRACE")
        
        # Add points layer
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
        
        logr_msg("Points layer added", level = "TRACE")
        
        # Final plot with formatting
        final_plot <- gg2_point + 
        ggplot2::labs(
          x = name_case(as.character(vals()$num_var)),
          y = name_case(as.character(vals()$chr_var))
        ) +
        ggplot2::theme(
          legend.position = "none",
          axis.text = ggplot2::element_text(color = "#ffffff"),
          axis.title = ggplot2::element_text(color = "#ffffff")
        )
        
        logr_msg("Raincloud plot successfully created", level = "INFO")
        
        return(final_plot)
        
      }, error = function(e) {
        logr_msg(
          paste0("Failed to create raincloud plot: ", e$message),
          level = "ERROR"
        )
        
        # Return minimal error plot
        ggplot2::ggplot() +
        ggplot2::annotate(
          "text",
          x = 0.5,
          y = 0.5,
          label = "Error creating plot. See logs for details."
        ) +
        ggplot2::theme_void()
      })
    })
  })
}