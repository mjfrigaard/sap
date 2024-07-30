withr::with_options(new = list(shiny.autoload.r = FALSE), code = {
  shiny::shinyApp(
    ui = shinyAppPkgs::movies_ui(bslib = TRUE), 
    server = shinyAppPkgs::movies_server)
})