options(scipen = 9999)
library(tidyr)
library(fst)

shinyApp(
  ui = devUI(),
  server = devServer
)
