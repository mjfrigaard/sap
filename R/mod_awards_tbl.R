#' User Interface for Awards Data Table
#'
#' @param id Shiny module ID.
#'
#' @return A UI for displaying a data table.
#' 
#' @section Outputs:
#' - `awards_table`: Data table.
#'
#' @seealso [mod_awards_tbl_server()]
#' 
#' @export
mod_awards_tbl_ui <- function(id) {
  ns <- NS(id)
    tagList(
      # reactable::reactableOutput(
      verbatimTextOutput(
        outputId = ns("awards_table"))
    )
}

#' Server Logic for Awards Data Table
#'
#' @param id Shiny module ID.
#' @param vals Reactive list of table parameters.
#'
#' @return Renders a data table based on selected parameters.
#' 
#' @section Reactive Inputs:
#' - `vals`: Reactive list of table parameters.
#'
#' @seealso [mod_awards_tbl_ui()]
#' 
#' @export
mod_awards_tbl_server <- function(id, vals) {
  moduleServer(id, function(input, output, session) {
    
    # output$awards_table <- reactable::renderReactable({
    output$awards_table <- renderPrint({
      req(vals())
      print(
        str(vals())
      )
      
      # tbl_data <- create_movie_awards(award = vals()$chr_var, 
      #   start_year = as.numeric(vals()$start_year), 
      #   end_year = as.numeric(vals()$end_year))
      # # normalize names
      # tbl_names <- name_case(names(tbl_data))
      # tbl <- stats::setNames(object = tbl_data, nm = tbl_names)
      # reactable::reactable(data = tbl)
    })

  })
}
