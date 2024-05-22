options(scipen = 100000000)

shinyApp(
  ui = devUI(),
  server = devServer, 
  options = list(test.mode = TRUE)
)
