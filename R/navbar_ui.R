#' User Interface for the Shiny Application
#'
#' This function defines the user interface for the Shiny application,
#' integrating Bootstrap and a custom JavaScript file.
#'
#' @section Navigation Panels:
#' - `Metrics`: Contains scatter plot settings and display.
#' - `By Year`: Contains year-based plots and table.
#'
#' @seealso [navbar_server()]
#'
#' @return A tagList containing the UI elements.
#'
#' @export
navbar_ui <- function() {
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
          full_screen = TRUE,
          bslib::layout_sidebar(
            sidebar = bslib::sidebar(
              class = "p-0",
              mod_point_vars_ui("scatter_inputs"),
            ),
            bslib::card_body(
              class = "p-0",
              mod_point_ui(id = "scatter"),
              bslib::card_footer(
                tags$blockquote(
                  tags$em(
                    tags$p(
                      "The data for this application comes from the ",
                      tags$a("Building web applications with Shiny",
                        href = "https://rstudio-education.github.io/shiny-course/"
                      ),
                      "tutorial"
                    )
                  )
                )
              )
            )
          )
        )
      ),
      bslib::nav_panel(
        "Counts",
        bslib::navset_card_tab(
          height = "800px",
          full_screen = TRUE,
          sidebar =
            bslib::sidebar(
              class = "p-0",
              mod_count_vars_ui("year")
            ),
          bslib::nav_panel(
            markdown("Waffle"),
            mod_waffle_ui(id = "waffle")
          ),
          bslib::nav_panel(
            markdown("Bars"),
            mod_hbar_ui(id = "hbar"),
          ),
          bslib::nav_panel(
            markdown("Table"),
            mod_tbl_ui(id = "cnt_tbl")
          )
        )
      ),
      bslib::nav_panel(
        "Distributions",
        bslib::navset_card_tab(
          full_screen = TRUE,
          sidebar =
            bslib::sidebar(
              class = "p-0",
              mod_dist_vars_ui("dist")
            ),
          bslib::nav_panel(
            markdown("Box plot"),
            mod_boxplot_ui(id = "box")
          ),
          bslib::nav_panel(
            markdown("Ridgeline"),
            mod_ridgeline_ui(id = "ridges")
          ),
          bslib::nav_panel(
            markdown("Rain Cloud"),
            mod_raincloud_ui(id = "cloud")
          ),
          bslib::nav_panel(
            markdown("Table"),
            mod_tbl_ui(id = "dist_tbl")
          )
        )
      )
    )
  )
}
