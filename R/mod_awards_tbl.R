#' UI for Awards Table module
#'
#' Creates a display for a reactive table showing awards data. This function 
#' is designed to work together with [mod_awards_tbl_server()].
#'
#' @param id A character string used to identify the namespace for the module.
#'
#' @return A `tagList` containing UI elements:
#'   * A reactable output for displaying the awards table
#'
#' @seealso [mod_awards_tbl_server()] for the server-side logic
#'
#' @examples
#' # UI implementation
#' ui <- fluidPage(
#'   mod_awards_tbl_ui("awards1")
#' )
#'
#' # Server implementation
#' server <- function(input, output, session) {
#'   mod_awards_tbl_server("awards1", data_reactive())
#' }
#'
mod_awards_tbl_ui <- function(id) {
  ns <- NS(id)
    tagList(
      gt::gt_output(
        outputId = ns("awards_table"))
    )
}

#' 
#' Awards Table Server Module
#'
#' Server function for the awards table display. Takes award selection and year
#' range values from a reactive source to generate a table showing movie
#' awards data.
#'
#' @param id Module ID for namespacing
#' @param vals Reactive providing values for award type and year range
#'
#' @seealso [mod_awards_tbl_ui()] The corresponding UI function
#' 
#' @export
#' 
mod_awards_tbl_server <- function(id, vals) {
  moduleServer(id, function(input, output, session) {
    
    output$awards_table <- gt::render_gt({
      # validate input values
      req(vals())
      
      logr_msg("Preparing awards table with selected parameters", 
        level = "DEBUG")
      logr_msg(glue::glue("Award: {vals()$award}, Year: {vals()$year}"),
        level = "TRACE")
      
      tryCatch({
        # create awards data 
        award <- as.character(vals()$award)
        year <- as.numeric(vals()$year)
        if (award == "picture/director") {
          awards <- get_award_recipients(sap::movies, 
                                         award = "picture/director", 
                                         year = year)
        } else {
          awards <- get_award_recipients(sap::movies, 
                                         award = "actor/actress", 
                                         year = year)
        }
        # normalize columns
        tbl_names <- name_case(names(awards))
        tbl_data <- stats::setNames(object = awards, nm = tbl_names)
        
        logr_msg(glue::glue("Generated awards table with {nrow(tbl_data)} rows"), 
        level = "INFO")
        
        # gt table
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
        
        # return empty data with message if error
        gt::gt(
          data.frame(
            Error = "Failed to generate table. Please try again.")
          )
        
      })
    })
  })
}
