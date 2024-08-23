#' User Interface for Counts Text
#'
#' @param id Shiny module ID.
#'
#' @return A UI for displaying a the time span.
#'
#' @section Outputs:
#' - `counts_text`: text output.
#'
#' @seealso [mod_counts_vbox_server()]
#'
#' @export
mod_counts_vbox_ui <- function(id) {
  ns <- NS(id)
  tagList(
    bslib::value_box(
      full_screen = FALSE, 
      fill = FALSE,
      title = markdown("#### Totals"), 
      value = textOutput(ns("counts_text")),
      showcase = bsicons::bs_icon("film"),
      h4(textOutput(ns("years_text")))
      )
    )
}

#' Server Logic for Counts Text
#'
#' @param id Shiny module ID.
#' @param vals Reactive list of table parameters.
#'
#' @return Renders a data table based on selected parameters.
#'
#' @section Reactive Inputs:
#' - `vals`: Reactive list of table parameters.
#'
#' @seealso [mod_counts_vbox_ui()]
#'
#' @export
mod_counts_vbox_server <- function(id, vals) {
  moduleServer(id, function(input, output, session) {
    
    output$counts_text <- renderText({
      req(vals())
      d <- subset(movies, 
                thtr_rel_year >= vals()$start_year &
                thtr_rel_year <= vals()$end_year)
        paste(length(unique(d$imdb_url)), "movies")
    })
    
    output$years_text <- renderText({
      req(vals())
      ts <- abs(vals()$start_year - vals()$end_year)
      paste(ts, " years")
    })
    
  })
}
