#' Application UI
#'
#' @return Shiny UI
app_ui <- function() {
  bslib::page_sidebar(
    title = "Movies Explorer",
    sidebar = bslib::sidebar(
      mod_inputs_ui("inputs"),
      mod_download_report_ui("download"),
      strong("About"),
      p("This application explores the movies dataset with interactive visualizations and data tables.")
    ),
    bslib::layout_columns(
      col_widths = c(12, 12),
      mod_visualization_ui("viz"),
      mod_data_table_ui("table")
    )
  )
}