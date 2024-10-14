<h1 align="center"> <code><strong>sap</strong></code> </h1>
<h3 align="center"> Code examples for <a href="https://mjfrigaard.github.io/shiny-app-pkgs/"> Shiny App-Packages </a> </h3>
<hr>

<hr>

# sap

`sap` provides the code examples in for the [Shiny App-Packages](https://mjfrigaard.github.io/shiny-app-pkgs/) book and the [Developing & Testing Your Shiny Application](https://mjfrigaard.github.io/dev-test-shiny/) workshop provided at R in Pharma (2023).

## Movie review data application

The original code and data for the Shiny app comes from the [Building Web Applications with Shiny](https://rstudio-education.github.io/shiny-course/) course.

# Using code examples

The branches in this repo contain a Shiny application in the various stages of development. The best way to access each branch/app is with the [`shinypak` package](https://mjfrigaard.github.io/shinypak/). 

```r
# install.packages("pak")
pak::pak("mjfrigaard/shinypak")
library(shinypak)
```

List all the apps with `list_apps()`


```r
head(list_apps())
#>                  branch        last_updated
#> 2     01_whole-app-game 2024-01-01 14:11:32
#> 1        02.1_shiny-app 2024-01-04 13:05:58
#> 4       02.2_movies-app 2024-01-04 13:07:59
#> 5         02.3_proj-app 2024-01-04 13:08:58
#> 6      03.1_description 2024-01-04 13:10:00
#> 7            03.2_rproj 2024-01-04 13:25:06
```

Launch an app with `launch()`

```r
launch(app = "02.3_proj-app")
```

Or use the terminal

``` bash
git clone https://github.com/mjfrigaard/sap.git
cd sap
git checkout <branch_name>
open sap.Rproj
```

------------------------------------------------------------------------

# Branches

View all the applications in the [`sap` branches](https://github.com/mjfrigaard/sap/branches/all).

## External resources 

### `10_debug-explore`

[`10_debug-explore`](https://github.com/mjfrigaard/sap/tree/10_debug-explore) gives an example of exploring application code with RStudio/Positron's debugging tools. 

The branch has the following apps: 

### launch_observe()

```r
launch_observe <- function() {
  ui <- bslib::page_fluid(
    titlePanel(p("Simple", code("observe()"), "Shiny App")),
    bslib::layout_column_wrap(
      width = 1/2,
      bslib::card(
        bslib::card_header("Press the Button"),
        actionButton(
          inputId = "btn", 
          label = "Click Me!")
      )
    )
  )
  server <- function(input, output, session) {
    observe({
      if (input$btn > 0) {  
        print("Clicked!")  
      }
    })
  }
  shinyApp(ui, server)
}
```

### launch_debug()

```r
launch_debug <- function() {
  ui <- bslib::page_fluid(
    titlePanel("Debug App"),
    bslib::layout_sidebar(
      sidebar = bslib::sidebar(
        actionButton("trigger", "Click Me!"),
        numericInput("input_num", "Enter a number:", value = 1)
      ),
      bslib::card(
        uiOutput("output_value"),
        uiOutput("reactive_value"),
        verbatimTextOutput("button")
      )
    )
  )

  server <- function(input, output, session) {
    reactive_value <- reactive({
      input$input_num
    })

    observe({
      isolated_value <- isolate(input$input_num)
      output$button <- renderPrint({
        paste("Button clicked! The isolated value is:", isolated_value)
      })
    }) |>
      bindEvent(input$trigger)

    output$output_value <- renderUI({
      markdown(
        paste("Isolated value from ", "`observe()`", ":", isolate(input$input_num))
      )
    })

    output$reactive_value <- renderUI({
      paste("Reactive value:", reactive_value())
    })
  }

  shinyApp(ui = ui, server = server)
}

```