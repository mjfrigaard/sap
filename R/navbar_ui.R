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

  tagList(
    tags$style(
      HTML("
      .reactable {
        background-color: #121212;
        color: #ffffff;
      }
      .reactable .rt-tbody .rt-tr-group {
        border-color: #2979ff;
      }
      .reactable .rt-thead .rt-th, .reactable .rt-tbody .rt-td {
        color: #ffffff;
      }
      .reactable .rt-thead .rt-th {
        background-color: #121212;
      }
      .reactable .rt-tbody .rt-td {
        background-color: #121212;
      }
    ")
  ),
    bslib::page_navbar(
      theme = bslib::bs_theme(
        version = 5,
        bg = "#000000",          # pure black background for maximum contrast
        fg = "#ffffff",          # white text color for sharp contrast
        primary = "#2979ff",     # bright blue primary color
        secondary = "#bdbdbd",   # light gray for secondary elements
        body_bg = "#121212",     # dark gray for the main content background
        base_font = sass::font_google("Roboto") # base font from Google
      ),
      title = "Movies",
      fillable = "Compare",
      bslib::nav_panel(
        "Compare",
        # Compare (ui) ----
        bslib::card(
          full_screen = TRUE,
          bslib::layout_sidebar(
            sidebar = bslib::sidebar(
              class = "p-0",
              ## Scatter inputs (UI) ---- 
              mod_compare_vars_ui("scatter_inputs"),
            ),
            bslib::card_body(
              class = "p-0",
              ## Scatter plot (UI) ----
              mod_compare_point_ui(id = "scatter"),
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
              mod_counts_vars_ui("year")
            ),
          bslib::nav_panel(
            markdown("Graphs"),
            ### Text (UI) ----
            mod_counts_vbox_ui("cnt_txt"),
            ### Bars (UI) ----
            mod_counts_bar_ui(id = "hbar"),
            ### Waffle (UI) ----
            mod_counts_waffle_ui(id = "waffle")
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
            markdown("Graphs"),
            ### Box plot (UI) ----
            mod_dist_box_ui(id = "box"),
            ### Rain Cloud plot (UI) ----
            mod_dist_raincloud_ui(id = "cloud")
          ),
          bslib::nav_panel(
            markdown("Table"),
            ### Distribution table (UI) ----
            mod_dist_tbl_ui("dist_tbl")
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
              ## Awards Vars (UI) ----
              mod_awards_vars_ui(id = "awards_vars"),
            ),
          bslib::nav_panel(
            markdown("Graphs"),
            ### Awards Graph (UI) ----
            mod_awards_point_ui(id = "awards_plot")
          ),
          bslib::nav_panel(
            markdown("Table"),
            ### Awards Table (UI) ----
            mod_awards_tbl_ui(id = "awards_table")
          )
        )
      )
    )
  )
}
