#' Define the User Interface for the Shiny Application
#'
#' This function constructs the UI layout of the Shiny application, including
#' input filters, slider controls, and movie selection elements.
#'
#' @return A `shiny.tag.list` object representing the application UI.
#'
#' @export
#'
db_app_ui <- function() {
  tagList(
    bslib::page_navbar(
      title = "Movies Explorer",
      id = "nav",
      sidebar = bslib::sidebar(
        conditionalPanel(
          "input.nav === 'Filters'",
          h4("Filters"),
          mod_select_input_ui("selects"),
          mod_slider_input_ui("sliders")
        ),
        conditionalPanel(
          "input.nav === 'Director and Cast'",
          h4("Director and Cast"),
          mod_text_input_ui("text")
        )
      ),
      bslib::nav_panel("Filters",
        bslib::card(
          mod_points_plotly_ui('plotly'),
          bslib::card_footer(
              em(
                paste0(
                  "Note: The Tomato Meter is the proportion of positive reviews",
                  " (as judged by the Rotten Tomatoes staff), and the Numeric rating is",
                  " a normalized 1-10 score of those reviews which have star ratings",
                  " (for example, 3 out of 4 stars)."
                )
              )
          )
        )
      ),
      bslib::nav_panel("Director and Cast",
        bslib::card(
          mod_filters_ui("filters"),
          bslib::card_header("Movies selected:"),
          verbatimTextOutput("vals")
        )
      )
    )
  )
}
