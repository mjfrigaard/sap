# Standalone app
launch_db_app <- function() {
  shiny::shinyApp(
    ui = db_app_ui(),
    server = db_app_server
  )
}

launch_db_app()