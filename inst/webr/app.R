# shinylive launcher: sap is installed from R-universe, which builds
# the WebAssembly binary that webR needs
library(shiny)
library(sap)

shinyApp(
  ui = movies_ui(bslib = TRUE),
  server = movies_server
)
