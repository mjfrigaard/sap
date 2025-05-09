#' UI for Awards Variables Module (5-Year Range)
#'
#' Creates UI elements for selecting award type and a 5-year release range using
#' a slider input. An auto-updating label shows the currently selected year range.
#'
#' @param id A character string used to identify the module namespace.
#'
#' @return A `tagList` containing:
#'   * A select input for award type (Films or Stars)
#'   * A sliderInput for a 5-year release range
#'   * A textOutput showing the selected year range
#'
#' @seealso [mod_awards_vars_server()] for the server logic
#'
#' @examples
#' ui <- fluidPage(mod_awards_vars_ui("awards1"))
#' server <- function(input, output, session) {
#'   mod_awards_vars_server("awards1")
#' }
#'
mod_awards_vars_ui <- function(id) {
  ns <- NS(id)
  tagList(
    markdown("**Award Type**"),
    selectInput(
      inputId = ns("award"),
      label = "Award Type",
      choices = c("actor/actress", "picture/director"),
      selected = "actor/actress"
    ),
    markdown("**Theater Release Year**"),
    sliderInput(
      inputId = ns("year"),
      label = "Select Year",
      min = 1970,
      max = 2014,
      value = 1987,
      step = 1, 
      sep = ""
    ),
    textOutput(ns("year_label"))
  )
}


#' Server Logic for Awards Variables Module (5-Year Range)
#'
#' Handles award type and a validated year slider input for release years.
#'
#' @param id Shiny module ID (character).
#'
#' @return A reactive list with:
#'   * `award`: Selected award type.
#'   * `year`: Selected year.       
#'
#' @seealso [mod_awards_vars_ui()] for the UI.
#'
#' @export
#'
mod_awards_vars_server <- function(id) {
  moduleServer(id, function(input, output, session) {
    ns <- session$ns
    initialized <- reactiveVal(FALSE)

    logr_msg("Initializing awards variables module", 
      level = "INFO")

    # label for selected range
    output$year_label <- renderText({
      req(input$year_range)
      h4(glue::glue("{input$year} Selected"))
    })

    # log changes
    observe({
      if (initialized()) {
        logr_msg(glue::glue(
          "Awards criteria updated: {input$award}, year {input$year}"
        ), level = "INFO")
      } else {
        initialized(TRUE)
      }
    }) |> bindEvent(input$award, input$year)

    # returned values 
    return(
      reactive({
        req(input$award, input$year)

        list(
          award = input$award,
          year = input$year
        )
      })
    )
  })
}
