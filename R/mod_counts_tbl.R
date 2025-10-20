#' UI for counts table module
#'
#' Creates a reactive table displaying count data. This function is designed
#' to work together with [mod_counts_tbl_server()].
#'
#' @param id A character string used to identify the namespace for the module.
#'
#' @return A `tagList` containing UI elements:
#'   * A reactive table output that displays the count data
#'
#' @seealso [mod_counts_tbl_server()] for the server-side logic
#'
#' @examples
#' # UI implementation
#' ui <- fluidPage(
#'   mod_counts_tbl_ui("counts1")
#' )
#'
#' # Server implementation
#' server <- function(input, output, session) {
#'   mod_counts_tbl_server("counts1", counts_data = reactive(data))
#' }
#'
mod_counts_tbl_ui <- function(id) {
  ns <- NS(id)
  tagList(
    reactable::reactableOutput(
      outputId = ns("counts_table")
    )
  )
}

#' Server function for the count table module
#'
#' Creates a reactive table showing movies based on selected filters. This 
#' function is designed to work together with a corresponding UI function.
#'
#' @param id A character string used to identify the namespace for the module.
#' @param vals A reactive expression that returns a list containing at least:
#'   * `start_year`: numeric value for the earliest year to include
#'   * `end_year`: numeric value for the latest year to include
#'   * `chr_var`: symbol representing the variable to display alongside title
#'
#' @return Creates the following reactive elements within the module's namespace:
#'   * `counts_table`: A reactive Reactable table with three columns:
#'      - Title: The movie title
#'      - The selected character variable from `vals()$chr_var`
#'      - Thtr Rel Year: The theatrical release year
#'
#' The table includes styling with a dark background, white text, and features 
#' such as highlighting, striping, and compact display.
#'
#' @details
#' The function filters the global `movies` dataset based on the year range
#' provided in `vals()`. Column names are normalized using the `name_case()` 
#' function before displaying.
#'
#' @seealso [mod_counts_tbl_ui()] The corresponding UI function for this module
#'
#' @examples
#' # Server implementation
#' server <- function(input, output, session) {
#'   # Create a reactive values list
#'   selected_vals <- reactive({
#'     list(
#'       start_year = 2000,
#'       end_year = 2010,
#'       chr_var = sym("Critics Rating")
#'     )
#'   })
#'   
#'   # Call the module server
#'   mod_counts_tbl_server("movie_table", selected_vals)
#' }
#'
mod_counts_tbl_server <- function(id, vals) {
  moduleServer(id, function(input, output, session) {
    
    output$counts_table <- reactable::renderReactable({
      req(vals())
      # subset
      tbl_data <- subset(
        movies,
        thtr_rel_year >= vals()$start_year &
        thtr_rel_year <= vals()$end_year
      )
      
      # normalize names
      tbl_names <- name_case(names(tbl_data))
      tbl_data <- setNames(tbl_data, nm = tbl_names)
      chr_var <- as.character(vals()$chr_var)
      tbl_data <- tbl_data[c("Title", chr_var, "Thtr Rel Year")]
      # reactable with dynamic row styling
      reactable::reactable(tbl_data,
        defaultPageSize = 25,
        borderless = TRUE,
        highlight = TRUE,
        striped = TRUE,
        compact = TRUE,
        style = list(
          backgroundColor = "#121212",
          color = "#ffffff"
        )
      )
    })
  })
}
