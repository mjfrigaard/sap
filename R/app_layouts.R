app_nav_ui <- function() {
  tagList(
    bslib::page_navbar(
      title = "Navbar",
      fillable = "Nav Panel 1",
      bslib::nav_panel(
        title = "Nav Panel 1", 
          bslib::layout_sidebar(
          sidebar = 
            bslib::sidebar(
              #class = "p-0", 
              "Sidebar 1"),
          bslib::card(
            bslib::card_header("header"),
            bslib::card_body("body"),
            bslib::card_footer("footer")
            )
          ),
        ),
      bslib::nav_panel(
        title = "Nav Panel 2",
        bslib::navset_card_tab(
          sidebar =
            bslib::sidebar(class = "p-0", 
              markdown("Card tab (shared sidebar)")
              ),
          bslib::nav_panel(
              markdown("Nav Panel 2a contents"),
              bslib::card(
                bslib::card_header("header"),
                bslib::card_body("body"),
                bslib::card_footer("footer")
              )
            ),
            bslib::nav_panel(
              markdown("Nav Panel 2b contents"),
              bslib::card(
                bslib::card_header("header"),
                bslib::card_body("body"),
                bslib::card_footer("footer")
              )
          )
        )
      ),
      bslib::nav_panel(
        title = "Nav Panel 3",
        bslib::navset_card_tab(
          sidebar =
            bslib::sidebar(class = "p-0", 
              markdown("Card tab (shared sidebar)")
              ),
          bslib::nav_panel(
              markdown("Nav Panel 2a contents"),
              bslib::card(
                bslib::card_header("header"),
                bslib::card_body("body"),
                bslib::card_footer("footer")
              )
            ),
            bslib::nav_panel(
              markdown("Nav Panel 2b contents"),
              bslib::card(
                bslib::card_header("header"),
                bslib::card_body("body"),
                bslib::card_footer("footer")
              )
          )
        )
      ),

    )
  )
}

app_nav_server <- function(input, output, session) {
  
}

shinyApp(ui = app_nav_ui, app_nav_server)