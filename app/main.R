# app/view/main.R

# shiny functions
box::use(
  shiny[
    NS, fluidPage, sidebarLayout, sidebarPanel,
    mainPanel, fluidRow, column, tags, icon,
    textOutput, moduleServer, renderText
  ]
)

# import modules
box::use(
  # load inputs module ----
  app / view / inputs,
  # load display module ----
  app / view / display
)

#' rap ui
#' @export
ui <- function(id) {
  ns <- NS(id)
  fluidPage(
    sidebarLayout(
      sidebarPanel(
        # use inputs module UI ----
        inputs$ui(ns("vals"))
      ),
      mainPanel(
        fluidRow(
          column(
            width = 12,
            tags$h3("rap")
          )
        ),
        fluidRow(
          column(
            width = 1,
            offset = 11,
            # example info button ---
            tags$button(
              id = "help-button",
              icon("info"),
              # add 'onclick' after rhino::build_sass()
              # and rhino::build_js()
              onclick = "App.showHelp()"
            )
          )
        ),
        fluidRow(
          column(
            width = 12,
            # use display module UI ----
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
    # use inputs module server ----
    selected_vars <- inputs$server(id = "vals")
    # use display module server ----
    display$server(
      id = "disp",
      var_inputs = selected_vars
    )
  })
}
