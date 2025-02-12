options(scipen = 100000000, shiny.testmode = TRUE)
library(tidyr)
library(fst)

shinyApp(
  ui = devUI(),
  server = devServer
)

