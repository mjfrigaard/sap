shiny::shinyApp(
  ui = moviesApp::movies_ui(bslib = TRUE), 
  server = moviesApp::movies_server)
