# install.packages(c('shiny', 'plotly', 'dplyr', 'RSQLite'))

library(sap)
library(plotly)
library(dplyr)
library(RSQLite)


# launch the app
shinyApp(
  ui = db_app_ui(),
  server = db_app_server
)
