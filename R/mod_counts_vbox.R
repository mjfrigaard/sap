#' UI for counts value box module
#'
#' Creates a value box displaying total counts and year range for movies.
#' This function is designed to work together with [mod_counts_vbox_server()].
#'
#' @param id A character string used to identify the namespace for the module.
#'
#' @return A `tagList` containing a `bslib::value_box` with:
#'   * A title displaying "Totals"
#'   * A value displaying the total count of movies (populated by server)
#'   * A film icon as showcase element
#'   * A subtitle displaying the year range of the movies (populated by server)
#'
#' @seealso [mod_counts_vbox_server()] for the server-side logic
#'
#' @examples
#' # UI implementation
#' ui <- fluidPage(
#'   mod_counts_vbox_ui("counts1")
#' )
#'
#' # Server implementation
#' server <- function(input, output, session) {
#'   mod_counts_vbox_server("counts1", reactive(filtered_data))
#' }
#'
#' @export
#' 
mod_counts_vbox_ui <- function(id) {
  ns <- NS(id)
  tagList(
    bslib::value_box(
      full_screen = FALSE, 
      fill = FALSE,
      title = markdown("#### Totals"), 
      value = textOutput(ns("counts_text")),
      showcase = bsicons::bs_icon("film"),
      h4(
        textOutput(ns("years_text"))
        )
      )
    )
}

#' Server Logic for Counts Text
#'
#' @param id Shiny module ID.
#' @param vals Reactive list of table parameters.
#'
#' @return Renders count information based on filtered data.
#'
#' @details
#' This server module generates two text outputs:
#' 1. The number of unique movies in the filtered dataset
#' 2. The span of years covered by the current filter
#'
#' @section Logging:
#' The module includes appropriate logging for data filtering operations and
#' rendering operations, with DEBUG level for data operations and TRACE for
#' render events.
#'
#' @seealso [mod_counts_vbox_ui()]
#'
#' @export
#' 
mod_counts_vbox_server <- function(id, vals) {
  moduleServer(id, function(input, output, session) {
    
    # Reactive to filter data based on year range
    filtered_data <- reactive({
      req(vals())
      
      logr_msg(
        glue::glue("Filtering movies between {vals()$start_year} and 
        {vals()$end_year}"),
        level = "DEBUG"
      )
      
      subset(movies, 
        thtr_rel_year >= vals()$start_year &
        thtr_rel_year <= vals()$end_year)
      })
      
      # Count of unique movies
      output$counts_text <- renderText({
        logr_msg("Rendering movie count text", level = "TRACE")
        
        tryCatch({
          movie_count <- length(unique(filtered_data()$imdb_url))
          
          logr_msg(
            glue::glue("Found {movie_count} unique movies in selected range"),
            level = "DEBUG"
          )
          
          paste(movie_count, "movies")
        }, error = function(e) {
          logr_msg(
            glue::glue("Error calculating movie count: {e$message}"),
            level = "ERROR"
          )
          "Error calculating movie count"
        })
      })
      
      # Year span text
      output$years_text <- renderText({
        logr_msg("Rendering year span text", 
          level = "TRACE")
        
        tryCatch({
          time_span <- abs(vals()$start_year - vals()$end_year)
          
          logr_msg(
            glue::glue("Calculated time span: {time_span} years"),
            level = "DEBUG"
          )
          
          paste(time_span, "years")
        }, error = function(e) {
          logr_msg(
            glue::glue("Error calculating year span: {e$message}"),
            level = "ERROR"
          )
          "Error calculating year span"
        })
      })
    })
  }