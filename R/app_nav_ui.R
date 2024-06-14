#' User Interface for the Shiny Application 
#'
#' This function defines the user interface for the Shiny application, 
#' integrating Bootstrap and a custom JavaScript file.
#' 
#' @section Navigation Panels:
#' - `Metrics`: Contains scatter plot settings and display.
#' - `By Year`: Contains year-based plots and table.
#' 
#' @seealso [app_nav_server()]
#'
#' @return A tagList containing the UI elements.
#' 
#' @export
app_nav_ui <- function() {
  
  # addResourcePath(
  #   prefix = 'www',
  #   directoryPath = system.file('www', package = 'moviesApp'))
  
  # bootstrap <- htmltools::htmlDependency(
  #   name = "bootstrap",
  #   version = "4.0.0",
  #   src = c(href = "https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/"),
  #   stylesheet = "css/bootstrap.min.css"
  # )

  # custom_js <- htmltools::htmlDependency(
  #   name = "custom-scripts",
  #   version = "1.0",
  #   src = "www",
  #   script = "scripts.js"
  # )

  tagList(
    # bootstrap,
    # custom_js,
    # div(class = "container",
    #   div(class = "jumbotron",
    #     h1("Movies Data Analysis Application")
    #   ),
      bslib::page_navbar(
        title = "Movies",
        fillable = "Compare",
        bslib::nav_panel(
          "Compare",
          bslib::card(
            bslib::layout_sidebar(
              sidebar = bslib::sidebar(
                class = "p-0",
                mod_vars_ui("scatter_inputs"),
              ),
              bslib::card_body(
                class = "p-0",
                mod_point_ui(id = "scatter"),
                verbatimTextOutput("vals")
              )
            )
          )
        ),
        bslib::nav_panel(
          "By Years",
          bslib::navset_card_tab(
            sidebar =
              bslib::sidebar(
                class = "p-0",
                mod_num_input_ui("year")
              ),
            bslib::nav_panel(
              markdown("Genre"),
              mod_vbar_ui(id = "genre")
            ),
            bslib::nav_panel(
              markdown("MPAA"),
              mod_hbar_ui(id = "mpaa"),
            ),
            bslib::nav_panel(
              markdown("Table"),
              mod_tbl_ui(id = "table")
            )
          )
        )
      )
  )
}

