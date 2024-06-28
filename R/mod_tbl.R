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
      # tableOutput(outputId = ns("table")),
      verbatimTextOutput(outputId = ns("table"))
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
    
    output$table <- renderPrint({
      req(vals())
      tspan <- abs(vals()$start_year - vals()$end_year)
      x_lab <- title_labs(as.character(vals()$chr_var))
      t <- paste("Time span =", tspan, "years")
      movies <- moviesApp::movies
      # convert to character 
      movies$chr_var <- as.character(movies[[vals()$chr_var]])
      # subset
      d <- subset(movies, 
              thtr_rel_year >= vals()$start_year &
              thtr_rel_year <= vals()$end_year)
      drows <- nrow(d)
      s <- paste("Total movies = ", drows)
      str(d)
    })

  })
}