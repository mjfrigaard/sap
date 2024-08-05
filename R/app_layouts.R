app_nav_ui <- function() {
  tagList(
    bslib::page_navbar(
      title = "Navbar",
      fillable = "Panel 1",
      bslib::nav_panel(
        title = "Panel 1", 
          bslib::layout_sidebar(
          sidebar = 
            bslib::sidebar(
              class = "p-0", 
              "Sidebar 1",
              ),
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
          ),
        ),
      bslib::nav_panel(
        title = "Panel 2",
        bslib::navset_card_tab(
          sidebar =
            bslib::sidebar(class = "p-0", 
              markdown("Card tab (shared sidebar)")
              ),
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
          sidebar =
            bslib::sidebar(class = "p-0", 
              markdown("Card tab (shared sidebar)")
              ),
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
              ),
              bslib::card(
                bslib::card_header("card header"),
                bslib::card_body("card body"),
                bslib::card_footer("card footer")
              )
          )
        )
      ),

    )
  )
}

app_nav_server <- function(input, output, session) {
  
  # scatter plot values 
  scatter_values <- mod_var_input_server("sidebar")

  mod_point_server(id = "scatter", vals = scatter_values)
}

shinyApp(ui = app_nav_ui, app_nav_server)