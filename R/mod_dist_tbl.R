#' UI for distribution table module
#'
#' Creates a reactive table to display distribution data. This function is 
#' designed to work together with [mod_dist_tbl_server()].
#'
#' @param id A character string used to identify the namespace for the module.
#'
#' @return A `tagList` containing a single UI element:
#'   * A reactable output that will display the distribution table
#'
#' @seealso [mod_dist_tbl_server()] for the server-side logic
#'
#' @examples
#' # UI implementation
#' ui <- fluidPage(
#'   mod_dist_vars_ui("vars"),
#'   mod_dist_tbl_ui("dist_tbl1")
#' )
#'
#' # Server implementation
#' server <- function(input, output, session) {
#' 
#'   vals <- mod_dist_vars_server("vars")
#' 
#'   mod_dist_tbl_server("dist_tbl1", vals = vals)
#' }
#'
#' @export
#' 
mod_dist_tbl_ui <- function(id) {
  ns <- NS(id)
    tagList(
      reactable::reactableOutput(
        outputId = ns("dist_table"))
    )
}

#' Server Logic for Distribution Data Table
#'
#' @param id Shiny module ID.
#' @param vals Reactive list of table parameters.
#'
#' @return Renders a data table based on selected parameters.
#' 
#' @section UI Function:
#'   Use with `mod_dist_tbl_ui()` to create the UI component for this module.
#' 
#' @seealso [mod_dist_tbl_ui()]
#'
#' @details
#'   This module creates a reactive data table that displays distribution 
#'   summaries based on the character and numeric variables selected from
#'   the `vals()` reactive input.
#' 
#' @export
#' 
mod_dist_tbl_server <- function(id, vals) {
  moduleServer(id, function(input, output, session) {
    
    output$dist_table <- reactable::renderReactable({
      logr_msg("Preparing distribution table in mod_dist_tbl_server",
      level = "TRACE")
      
      req(vals())
      
      tryCatch({
        # Capture variables from reactive input
        chr_var <- as.character(vals()$chr_var)
        num_var <- as.character(vals()$num_var)
        
        logr_msg(glue::glue("Building table with character var: {chr_var} and 
        numeric var: {num_var}"), level = "DEBUG")
        
        # Transform movie data names
        mv_nms <- names(sap::movies) |> name_case()
        movie_data <- setNames(object = sap::movies, nm = mv_nms)
        
        # Generate summary data
        tbl_data <- dist_var_summary(data = movie_data, chr_var, num_var)
        
        logr_msg(glue::glue("Generated summary table with {nrow(tbl_data)} rows"),
        level = "INFO")
        
        # Create reactable
        reactable::reactable(
          data = tbl_data,
          borderless = TRUE,
          compact = TRUE,
          highlight = TRUE,
          striped = TRUE,
          style = list(
            backgroundColor = "#121212",
            color = "#ffffff"
          )
        )
      }, error = function(e) {
        logr_msg(glue::glue("Failed to generate distribution table. 
        Error: {e$message}"), level = "ERROR")
        
        # Return empty data frame with message if there's an error
        reactable::reactable(
          data.frame(Error = "Failed to generate table. Please try again."),
          striped = TRUE
        )
      })
    })
  })
}