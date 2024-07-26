shinyApp(
  ui = shinyAppPkgs::movies_ui(bslib = TRUE), 
  server = shinyAppPkgs::movies_server)
