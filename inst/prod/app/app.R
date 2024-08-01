shiny::shinyApp(
  ui = shinyrPkgs::movies_ui(bslib = TRUE), 
  server = shinyrPkgs::movies_server)
