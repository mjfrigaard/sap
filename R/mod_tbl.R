#' User Interface for Data Table
#'
#' @param id Shiny module ID.
#'
#' @return A UI for displaying a data table.
#' 
#' @section Outputs:
#' - `year_table`: Data table.
#'
#' @seealso [mod_tbl_server()]
#' 
#' @export
mod_tbl_ui <- function(id) {
  ns <- NS(id)
    tagList(
      # tableOutput(outputId = ns("year_table")),
      verbatimTextOutput(outputId = ns("vals"))
    )
}

#' Server Logic for Data Table
#'
#' @param id Shiny module ID.
#' @param vals Reactive list of table parameters.
#'
#' @return Renders a data table based on selected parameters.
#' 
#' @section Reactive Inputs:
#' - `vals`: Reactive list of table parameters.
#'
#' @seealso [mod_tbl_ui()]
#' 
#' @export
mod_tbl_server <- function(id, vals) {
  moduleServer(id, function(input, output, session) {
    
    output$vals <- renderPrint({
      req(vals())
      str(vals())
    })
      
    
  # output$year_table <- renderTable({
  #       req(tvals())
  #     tbl_data <- subset(movies,
  #       thtr_rel_year == tvals()$year,
  #       select = c("title", "studio", "director")) |>
  #       setNames(c("Title", "Studio", "Director"))
  #     tbl_data
  #   })

  })
}