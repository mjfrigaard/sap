withr::with_options(new = list(shiny.autoload.r = FALSE), code = {
  shiny::shinyApp(
    ui = shinyrPkgs::movies_ui(bslib = TRUE), 
    server = shinyrPkgs::movies_server)
})
