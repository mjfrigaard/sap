#' UI for counts table module
#'
#' Creates a gt table displaying count data. This function is designed
#' to work together with [mod_counts_tbl_server()].
#'
#' @param id A character string used to identify the namespace for the module.
#'
#' @return A `tagList` containing UI elements:
#'   * A gt table output that displays the count data
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
#' @export
mod_counts_tbl_ui <- function(id) {
  ns <- NS(id)
  tagList(
    gt::gt_output(
      outputId = ns("counts_table")
    )
  )
}

#' Server function for the count table module
#'
#' Creates a gt table showing movies based on selected filters. This 
#' function is designed to work together with a corresponding UI function.
#'
#' @param id A character string used to identify the namespace for the module.
#' @param vals A reactive expression that returns a list containing at least:
#'   * `start_year`: numeric value for the earliest year to include
#'   * `end_year`: numeric value for the latest year to include
#'   * `chr_var`: symbol representing the variable to display alongside title
#'
#' @return Creates the following reactive elements within the module's namespace:
#'   * `counts_table`: A reactive gt table with three columns:
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
#' @export
#' 
mod_counts_tbl_server <- function(id, vals) {
  moduleServer(id, function(input, output, session) {
    
    output$counts_table <- gt::render_gt({
      req(vals())
      # subset
      count_data <- subset(
        movies,
        thtr_rel_year >= vals()$start_year &
        thtr_rel_year <= vals()$end_year
      )

      # convert selected variable to snake_case
      group_var <- name_case(as.character(vals()$chr_var), case = "lower")

      # count per group using tidy evaluation
      tbl_data <- count_data |>
        dplyr::group_by(.data[[group_var]]) |>
        dplyr::summarise(n = dplyr::n(), .groups = "drop") |>
        dplyr::arrange(dplyr::desc(n))
      
      # normalize column names in the data
      names(tbl_data) <- name_case(names(tbl_data))
      
      # gt table with dark theme styling
      gt::gt(tbl_data) |> 
      gt::tab_options(
        table.width = gt::pct(100),
        table.font.color = "#ffffff",
        table.align = "left",
        heading.align = "left",
        table.background.color = "#121212",
        column_labels.background.color = "#1e1e1e",
        table.font.size = gt::px(20),
        table.border.top.style = "hidden",
        table.border.bottom.style = "hidden"
      ) |> 
      gt::opt_row_striping()
    })
    
  })
}