withr::with_options(new = list(shiny.autoload.r = FALSE), code = {
  shiny::shinyApp(
    ui = moviesApp::movies_ui(bslib = TRUE), 
    server = moviesApp::movies_server)
})