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
  addResourcePath(
    prefix = 'www',
    directoryPath = system.file('www', package = 'shinyrPkgs'))

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
              # scatter inputs (UI) ---- 
              mod_point_vars_ui("scatter_inputs"),
            ),
            bslib::card_body(
              class = "p-0",
              # scatter plot (UI) ----
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
        # Counts (UI) ----
        "Counts",
        bslib::navset_card_tab(
          height = "800px",
          full_screen = TRUE,
          sidebar =
            bslib::sidebar(
              class = "p-0",
              ## Count Vars (UI) ----
              mod_count_vars_ui("year")
            ),
          bslib::nav_panel(
            markdown("Graphs"),
            markdown("*Bars*"),
            ### Bars (UI) ----
            mod_hbar_ui(id = "hbar"),
            markdown("*Waffle*"),
            ### Waffle (UI) ----
            mod_waffle_ui(id = "waffle")
          ),
          bslib::nav_panel(
            ### Counts Table (UI) ----
            markdown("Table"),
            mod_counts_tbl_ui(id = "cnt_tbl")
          )
        )
      ),
      bslib::nav_panel(
        "Distributions",
        # Distributions (UI) ----
        bslib::navset_card_tab(
          sidebar =
            bslib::sidebar(
              class = "p-0",
              ## Dist Vars (UI) ----
              mod_dist_vars_ui("dist")
            ),
          bslib::nav_panel(
            markdown("Box plot"),
            ### Box plot (UI) ----
            markdown("*Box plot*"),
            mod_boxplot_ui(id = "box")
          ),
          bslib::nav_panel(
            markdown("Rain Cloud"),
            ### Rain Cloud plot (UI) ----
            markdown("*Rain Cloud*"),
            mod_raincloud_ui(id = "cloud")
          )
        )
      ),
      bslib::nav_panel(
        "Awards",
        # Awards (UI) ----
        bslib::navset_card_tab(
          full_screen = TRUE,
          sidebar =
            bslib::sidebar(
              class = "p-0",
              ## Awards Vars ----
              code("awards variables")
            ),
          bslib::nav_panel(
            markdown("Best Director"),
            ### Best Director Table (UI) ----
          ),
          bslib::nav_panel(
            markdown("Best Actor"),
            ### Best Actor Table (UI) ----
          )
        )
      )
    )
  )
}
