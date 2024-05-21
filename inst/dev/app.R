options(scipen = 100000000)
library(tidyr)
library(fst)

shinyApp(
  ui = devUI(),
  server = devServer
)
