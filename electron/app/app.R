# shinyelectron launcher: shinyelectron owns the port and process,
# so this file returns a shiny.appobj instead of calling launch_app()
library(shiny)
library(sap)

shinyApp(
  ui = movies_ui(bslib = TRUE),
  server = movies_server
)
