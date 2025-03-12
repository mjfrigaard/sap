#' slider inputs shiny module (UI)
#'
#' @param id shiny module id
#'
#' @export
#' 
mod_slider_input_ui <- function(id) {
    ns <- shiny::NS(id)
        shiny::tagList(
        sliderInput(
          inputId = ns("reviews"),
          label = strong("Number of Rotten Tomatoes reviews"),
          min = 20,
          max = 300,
          value = 100,
          step = 20
        ),
        sliderInput(
          inputId = ns("year"),
          label = strong("Release year"),
          min = 1940,
          max = 2014,
          value = c(1970, 2014),
          sep = ""
        ),
        sliderInput(
          inputId = ns("oscars"),
          label = strong("Number of Oscar wins"),
          min = 0,
          max = 4,
          value = 0,
          step = 1
        ),
        sliderInput(
          inputId = ns("boxoffice"),
          label = strong("Dollars at Box Office*"),
          min = 0,
          max = 800,
          value = c(0, 500),
          step = 1
        ),
        tags$small(
          em('*In millions')
          )
      )
    }
#' slider inputs shiny module (server)
#'
#' @param id shiny module id
#'
#' @export
#' 
mod_slider_input_server <- function(id) {
    shiny::moduleServer(id, function(input, output, session) {
        ns <- session$ns

      # Due to dplyr issue #318, we need temp variables for input values
      return(
        reactive(
          list(
          'reviews' = input$reviews,
          'oscars' = input$oscars,
          'minyear' = input$year[1],
          'maxyear' = input$year[2],
          'minboxoffice' = input$boxoffice[1] * 1e6,
          'maxboxoffice' = input$boxoffice[2] * 1e6
          )
        )
      )

    })
}
