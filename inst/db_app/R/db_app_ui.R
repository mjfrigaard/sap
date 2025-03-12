# db_app_ui.R
db_app_ui <- function() {
  shiny::fluidPage(
    shiny::titlePanel("Movie explorer"),
    shiny::fluidRow(
      shiny::column(
        width = 3,
        mod_graph_inputs_ui("graph_inputs")
      ),
      shiny::column(
        width = 9,
        mod_graph_output_ui("graph_outputs")
      )
    )
  )
}