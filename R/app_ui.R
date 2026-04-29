#' Application UI
#'
#' @return Shiny UI
app_ui <- function() {
  page_sidebar(
    title = "Movies Explorer",
    sidebar = sidebar(
      h4("About"),
      p("This application explores the movies dataset with interactive visualizations and data tables."),
      hr(),
      mod_inputs_ui("inputs"),
      hr(),
      mod_download_report_ui("download")
    ),
    layout_columns(
      col_widths = c(12, 12),
      mod_visualization_ui("viz"),
      mod_data_table_ui("table")
    )
  )
}