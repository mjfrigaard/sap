shinyApp(
  ui = sap::movies_ui(bslib = TRUE), 
  server = sap::movies_server)
