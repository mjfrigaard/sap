#' User Interface for Awards Data Table
#'
#' @param id Shiny module ID.
#'
#' @return A UI for displaying a data table.
#' 
#' @export
#' 
mod_awards_tbl_ui <- function(id) {
  ns <- NS(id)
    tagList(
      reactable::reactableOutput(
        outputId = ns("awards_table"))
    )
}


#' Awards Table Server Module
#'
#' Server function for the awards table display. Takes award selection and year
#' range values from a reactive source to generate a table showing movie
#' awards data.
#'
#' @param id Module's ID for namespacing
#' @param vals Reactive providing values for award type and year range
#'
#' @seealso mod_awards_tbl_ui The corresponding UI function
mod_awards_tbl_server <- function(id, vals) {
  moduleServer(id, function(input, output, session) {
    
    output$awards_table <- reactable::renderReactable({
      # Validate input values
      req(vals())
      
      logr_msg("Preparing awards table with selected parameters", level = "DEBUG")
      logr_msg(glue::glue("Award: {vals()$award}, Years: {vals()$start_year}-
      {vals()$end_year}"), level = "TRACE")
      
      tryCatch({
        # Create awards data table
        tbl_data <- create_movie_awards(movies,
          award = as.character(vals()$award),
          start_year = as.numeric(vals()$start_year),
          end_year = as.numeric(vals()$end_year)
        )
        
        logr_msg(glue::glue("Generated awards table with {nrow(tbl_data)} rows"), 
        level = "INFO")
        
        # Normalize column names
        tbl_names <- name_case(names(tbl_data))
        tbl <- stats::setNames(object = tbl_data, nm = tbl_names)
        
        # Return reactable
        reactable::reactable(
          data = tbl,
          borderless = TRUE,
          highlight = TRUE,
          striped = TRUE,
          compact = TRUE,
          style = list(
            backgroundColor = "#121212",
            color = "#ffffff"
          )
        )
      }, error = function(e) {
        logr_msg(glue::glue("Failed to generate awards table: {e$message}"),
        level = "ERROR")
        # Return empty data frame to avoid breaking the UI
        reactable::reactable(data.frame())
      })
    })
  })
}