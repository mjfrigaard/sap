library(leaflet)

# Choices for drop-downs
vars <- c(
  "Is SuperZIP?" = "superzip",
  "Centile score" = "centile",
  "College education" = "college",
  "Median income" = "income",
  "Population" = "adultpop"
)

navbarPage("Superzip",
  id = "nav",
  tabPanel(
    "Interactive map",
    div(
      class = "outer",
      tags$head(
        # Include our custom CSS
        includeCSS("styles.css"),
        includeScript("gomap.js")
      ),
      # If not using custom CSS, set height of leafletOutput to a number instead of percent
      leafletOutput("map", width = "100%", height = "100%"),
      # Shiny versions prior to 0.11 should use class = "modal" instead.
      absolutePanel(
        id = "controls", 
        class = "panel panel-default", 
        fixed = TRUE,
        draggable = TRUE, 
        top = 60, 
        left = "auto", 
        right = 20, 
        bottom = "auto",
        width = 330, 
        height = "auto",
        h2("ZIP explorer"),
        selectInput("color", "Color", vars),
        selectInput("size", "Size", vars, selected = "adultpop"),
        conditionalPanel(
          "input.color == 'superzip' || input.size == 'superzip'",
          # Only prompt for threshold when coloring or sizing by superzip
          numericInput("threshold", 
            "SuperZIP threshold (top n percentile)",
            5)
        ),
        plotOutput("histCentile", 
          height = 200),
        plotOutput("scatterCollegeIncome", 
          height = 250)
      ),
      tags$div(
        id = "cite",
        "Data compiled for ", 
        tags$em("Coming Apart: The State of White America, 1960–2010"), 
        " by Charles Murray (Crown Forum, 2012)."
      )
    )
  ),
  tabPanel(
    "Data explorer",
    fluidRow(
      column(width = 3,
        selectInput(
          inputId = "states", 
          label = "States", 
          choices = 
            c("All states" = "", 
              structure(state.abb, names = state.name), 
              "Washington, DC" = "DC"), 
          multiple = TRUE)
      ),
      column(width = 3,
        conditionalPanel("input.states",
          selectInput(
            inputId = "cities", 
            label = "Cities", 
            choices = c("All cities" = ""), 
            multiple = TRUE)
        )
      ),
      column(width = 3,
        conditionalPanel("input.states",
          selectInput(
            inputId = "zipcodes", 
            label = "Zipcodes", 
            choices = c("All zipcodes" = ""), 
            multiple = TRUE)
        )
      )
    ),
    fluidRow(
      column(width = 1,
        numericInput(
          inputId = "minScore", 
          label = "Min score", 
          min = 0, max = 100, value = 0)
      ),
      column(width = 1,
        numericInput(
          inputId = "maxScore", 
          label = "Max score", 
          min = 0, max = 100, value = 100)
      )
    ),
    hr(),
    DT::dataTableOutput("ziptable")
  ),
  conditionalPanel("false", icon("fs-crosshair"))
)
