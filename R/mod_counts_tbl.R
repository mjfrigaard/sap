#' User Interface for Counts Data Table
#'
#' @param id Shiny module ID.
#'
#' @return A UI for displaying a data table.
#' 
#' @section Outputs:
#' - `counts_table`: Data table.
#'
#' @seealso [mod_counts_tbl_server()]
#' 
#' @export
mod_counts_tbl_ui <- function(id) {
  ns <- NS(id)
    tagList(
      reactable::reactableOutput(outputId = ns("counts_table"))
    )
}

#' Server Logic for Counts Data Table
#'
#' @param id Shiny module ID.
#' @param vals Reactive list of table parameters.
#'
#' @return Renders a data table based on selected parameters.
#' 
#' @section Reactive Inputs:
#' - `vals`: Reactive list of table parameters.
#'
#' @seealso [mod_counts_tbl_ui()]
#' 
#' @export
mod_counts_tbl_server <- function(id, vals) {
  moduleServer(id, function(input, output, session) {
    
    output$counts_table <- reactable::renderReactable({
      req(vals())
      # subset
      tbl_data <- subset(movies,
              thtr_rel_year >= vals()$start_year &
              thtr_rel_year <= vals()$end_year)
      chr_var <- as.character(vals()$chr_var)
      tbl_data_sorted <- tbl_data[order(tbl_data[[chr_var]]), ]
      # normalize names
      tbl_names <- name_case(names(tbl_data_sorted))
      # str(tbl_data_sorted)
      tbl <- stats::setNames(object = tbl_data_sorted, nm = tbl_names)
      reactable::reactable(data = tbl)
    })

  })
}
