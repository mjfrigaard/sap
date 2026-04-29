#' Data Table Module UI
#'
#' @param id Module namespace
#' @return Shiny UI element
mod_data_table_ui <- function(id) {
  ns <- NS(id)

  card(
    card_header(h5("Movies Data Table")),
    card_body(
      reactable::reactableOutput(ns("data_table"))
    )
  )
}

#' Data Table Module Server
#'
#' @param id Module namespace
#' @param data Reactive data
#' @param inputs List of reactive inputs from inputs module
#' @return Reactive filtered data
mod_data_table_server <- function(id, data, inputs) {
  moduleServer(id, function(input, output, session) {

    filtered_data <- reactive({
      req(data(), inputs$genre_filter())
      df <- data()

      if (inputs$genre_filter() != "All") {
        df <- df[df$genre == inputs$genre_filter(), ]
      }

      df
    })

    output$data_table <- reactable::renderReactable({
      reactable::reactable(
        filtered_data(),
        defaultPageSize = 10,
        searchable = TRUE,
        resizable = TRUE,
        highlight = TRUE
      )
    })

    return(filtered_data)
  })
}
