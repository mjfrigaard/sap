#' Create the User Interface for the Application Navbar
#'
#' This function generates the UI for a Shiny application that uses a Bootstrap 5 navbar. 
#' The navbar contains multiple panels, each with a sidebar layout or card-based tabs.
#' 
#' @param theme `"dark"` or `"light"`
#'
#' @return A UI definition that can be passed to a Shiny app's `ui` parameter.
#' 
app_nav_ui <- function(theme = "light") {

  if (theme == "dark") {
    selected_theme <- bslib::bs_theme(
      version = 5,
      bg = "#000000",
      fg = "#ffffff",
      body_bg = "#121212",
      primary = "#2979ff",
      secondary = "#bdbdbd",
      base_font = sass::font_google("Roboto")
    )
  } else {
    selected_theme <- bslib::bs_theme(
      version = 5,
      bg = "#ffffff",
      fg = "#000000",
      primary = "#007bff",
      secondary = "#6c757d",
      body_bg = "#f8f9fa",
      base_font = sass::font_google("Ubuntu")
    )
  }

  tagList(
    bslib::page_navbar(
      theme = selected_theme,
      title = "Navbar",
      fillable = "Panel 1",
      bslib::nav_panel(
        title = "Panel 1", 
        bslib::layout_sidebar(
          sidebar = bslib::sidebar(class = "p-0", "Sidebar 1"),
          bslib::card(
            bslib::card_header("card 1 header"),
            bslib::card_body(class = "p-10", "card 1 body"),
            bslib::card_footer("card 1 footer")
          ),
          bslib::card(
            bslib::card_header("card 2 header"),
            bslib::card_body(class = "p-10", "card 2 body"),
            bslib::card_footer("card 2 footer")
          )
        )
      ),
      bslib::nav_panel(
        title = "Panel 2",
        bslib::navset_card_tab(
          sidebar = bslib::sidebar(class = "p-0", markdown("Card tab (shared sidebar)")),
          bslib::nav_panel(
            markdown("Panel 2a contents"),
            bslib::card(
              bslib::card_header("card header"),
              bslib::card_body("card body"),
              bslib::card_footer("card footer")
            ),
            bslib::card(
              bslib::card_header("card header"),
              bslib::card_body("card body"),
              bslib::card_footer("card footer")
            )
          ),
          bslib::nav_panel(
            markdown("Panel 2b contents"),
            bslib::card(
              bslib::card_header("card header"),
              bslib::card_body("card body"),
              bslib::card_footer("card footer")
            )
          )
        )
      ),
      bslib::nav_panel(
        title = "Panel 3",
        bslib::navset_card_tab(
          sidebar = bslib::sidebar(class = "p-0", markdown("Card tab (shared sidebar)")),
          bslib::nav_panel(
            markdown("Panel 3a contents"),
            bslib::card(
              bslib::card_header("card header"),
              bslib::card_body("card body"),
              bslib::card_footer("card footer")
            ),
            bslib::card(
              bslib::card_header("card header"),
              bslib::card_body("card body"),
              bslib::card_footer("card footer")
            )
          ),
          bslib::nav_panel(
            markdown("Panel 3b contents"),
            bslib::card(
              bslib::card_header("card header"),
              bslib::card_body("card body"),
              bslib::card_footer("card footer")
            ),
            bslib::card(
              bslib::card_header("card header"),
              bslib::card_body("card body"),
              bslib::card_footer("card footer")
            )
          )
        )
      ),
      bslib::nav_panel(
        title = "Panel 4",
        bslib::navset_card_tab(
          sidebar = bslib::sidebar(class = "p-0", markdown("Card tab (shared sidebar)")),
          bslib::nav_panel(
            markdown("Panel 4a contents"),
            bslib::card(
              bslib::card_header("card header"),
              bslib::card_body("card body"),
              bslib::card_footer("card footer")
            ),
            bslib::card(
              bslib::card_header("card header"),
              bslib::card_body("card body"),
              bslib::card_footer("card footer")
            )
          ),
          bslib::nav_panel(
            markdown("Panel 4b contents"),
            bslib::card(
              bslib::card_header("card header"),
              bslib::card_body("card body"),
              bslib::card_footer("card footer")
            ),
            bslib::card(
              bslib::card_header("card header"),
              bslib::card_body("card body"),
              bslib::card_footer("card footer")
            )
          )
        )
      )
    )
  )
}


#' Server Logic for the Application Navbar
#'
#' This function provides the server-side logic for the Shiny application 
#' using the navbar UI created by `app_nav_ui`. It is a placeholder function 
#' with no implemented logic.
#'
#' @param input Shiny's input object.
#' @param output Shiny's output object.
#' @param session Shiny's session object.
#' @return None.
#' 
app_nav_server <- function(input, output, session) {

}

#' Run the Navbar Demo Application
#'
#' This function launches a Shiny application that demonstrates the UI and 
#' server logic created by `app_nav_ui` and `app_nav_server`.
#' 
#' @param ... arguments passed to `app_nav_ui()`
#'
#' @return A Shiny app object.
#' 
#' @export
demo_app_navbar <- function(...) {
  shinyApp(
    ui = app_nav_ui(...), 
    server = app_nav_server)
}


