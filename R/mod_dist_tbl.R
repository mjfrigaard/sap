#' UI for distribution table module
#'
#' Creates a reactive table to display distribution data. This function is 
#' designed to work together with [mod_dist_tbl_server()].
#'
#' @param id A character string used to identify the namespace for the module.
#'
#' @return A `tagList` containing a single UI element:
#'   * A gt output that will display the distribution table
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
    gt::gt_output(
      outputId = ns("dist_table")
    )
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
    
    output$dist_table <- gt::render_gt({
      logr_msg("Preparing distribution table in mod_dist_tbl_server",
      level = "TRACE")
      
      req(vals())
      
      tryCatch({
        # capture variables from reactive input
        chr_var <- as.character(vals()$chr_var)
        num_var <- as.character(vals()$num_var)
        
        logr_msg(glue::glue("Building table with character var: {chr_var} and 
        numeric var: {num_var}"), 
          level = "DEBUG")
        
        # transform movie data names
        mv_nms <- names(sap::movies) |> name_case()
        movie_data <- setNames(object = sap::movies, nm = mv_nms)
        
        # generate summary data
        tbl_data <- dist_var_summary(data = movie_data, chr_var, num_var)
        
        logr_msg(glue::glue("Generated summary table with {nrow(tbl_data)} rows"),
        level = "INFO")
        
        # create gt table
        tbl_data |>
        gt::gt() |>
        gt::tab_options(
          table.width = gt::pct(100),
          table.background.color = "#121212",
          table.font.color = "#ffffff",
          table.border.top.style = "none",
          table.border.bottom.style = "none",
          table.font.size = gt::px(20)
        ) |>
        gt::opt_row_striping()
        
      }, error = function(e) {
        logr_msg(glue::glue("Failed to generate distribution table. 
        Error: {e$message}"), 
          level = "ERROR")
        
        # return empty data frame with message if there's an error
        data.frame(Error = "Failed to generate table. Please try again.") |>
          gt::gt()
      })
    })
  })
}


