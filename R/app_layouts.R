app_nav_ui <- function() {
  tagList(
    bslib::page_navbar(
      title = "Navbar",
      fillable = "Compare",
      bslib::nav_panel(title = "Compare", 
        "Compare", 
        bslib::card(
          bslib::layout_sidebar(
          sidebar = 
            bslib::sidebar(class = "p-0", 
              "Scatter sidebar")
            )
          )
        ),
      bslib::nav_panel(
        "More Graphs",
        bslib::navset_card_tab(
          sidebar =
            bslib::sidebar(class = "p-0", 
              markdown("Shared sidebar contents")
              ),
          bslib::nav_panel(
              markdown("Card 1 contents")
            ),
            bslib::nav_panel(
              markdown("Card 2 contents"),
          )
        )
      )
    )
  )
}

app_nav_server <- function(input, output, session) {
  
}

shinyApp(ui = app_nav_ui, app_nav_server)