library(bslib)
source("chooser.R")

chooserUI <- function() {
  tagList(
    page_fillable(
      h1("Example", code("chooser"), "dashboard"),
      layout_columns(
        col_widths = 6,
        card(
          full_screen = TRUE,
          card_header(
            markdown("#### **Column A**")
            ),
          markdown("Select a state:"),
          chooserInput(
            inputId = "choiceA",
            leftLabel = "Available",
            rightLabel = "Selected",
            leftChoices = state.name,
            rightChoices = c(),
            size = 5,
            multiple = TRUE
          )
        ),
        card(
          full_screen = TRUE,
          card_header(
            markdown("#### **Column B**")
          ),
          markdown("The output below is **`input$choiceA$left`**"),
          verbatimTextOutput(outputId = "selection")
        ),
        layout_sidebar(
          sidebar = sidebar(
            position = "right"
          ),
          verbatimTextOutput(outputId = "vals")
    )
  )))
}

chooseUI <- function() {
  tagList(
    bslib::page_fillable(
      layout_columns(
        card(
          card_header(class = "bg-dark", "A header"),
          markdown("Some text with a [link](https://github.com)."),
          chooserInput(
            inputId = "mychooser",
            leftLabel = "Available frobs",
            rightLabel = "Selected frobs",
            leftChoices = state.name,
            rightChoices = c(),
            size = 10,
            multiple = TRUE
          )
        ),
        card(
          card_header(class = "bg-dark", "A header"),
          markdown("Some text with a [link](https://github.com)."),
          verbatimTextOutput(outputId = "selection")
        )
      )
    )
  )
}

chooserServer <- function(input, output, session) {
  output$selection <- renderPrint(
    input$choiceA$left
  )
  output$vals <- renderPrint({
    x <- reactiveValuesToList(x = input, all.names = TRUE)
    print(x)
  })
}

shinyApp(
  ui = chooserUI,
  server = chooserServer
)
