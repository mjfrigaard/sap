# app/main.R

# shiny functions
box::use(
  shiny[
    NS, fluidPage, sidebarLayout, sidebarPanel, 
    mainPanel, fluidRow, column, tags, icon,
    plotOutput, moduleServer, renderPlot
  ],
  shinythemes[shinytheme]
)

# import modules ----
box::use(
  ## load inputs module
  app / view / inputs,
  ## load display module 
  app / view / display,
  ## load clicks module 
  app / view / clicks,
  ## load message module 
  app / view / message,
)

#' rap ui
#' @export
ui <- function(id) {
  ns <- NS(id)
  fluidPage(theme = shinytheme("spacelab"),
    sidebarLayout(
      sidebarPanel(
        # use inputs module UI 
        inputs$ui(ns("vals"))
        ),
      mainPanel(
        fluidRow(
              # use clicks module UI 
              clicks$ui(ns("clicks")),
              # use message module UI 
              message$ui(ns("message"))
          ),
        fluidRow(
          column(
            width = 1,
            offset = 11,
            # example info button 
            tags$button(id = "help-button",
              icon("info"),
              # add 'onclick' after rhino::build_sass()
              # and rhino::build_js()
              onclick = "App.showHelp()")
          )
        ),
        fluidRow(
            column(
              width = 12,
              tags$h3("rap"),
              # use display module UI 
            display$ui(ns("disp"))
            )
          )
        )
      )
    )
}

#' rap server
#' @export
server <- function(id) {
  
  moduleServer(id, function(input, output, session) {
    # use inputs module server 
    selected_vars <- inputs$server(id = "vals")
    # use display module server 
    display$server(
      id = "disp",
      var_inputs = selected_vars
    )
  })
  
  moduleServer(id, function(input, output, session) {
    clicks$server("clicks")
    message$server("message")
  })
  
}
