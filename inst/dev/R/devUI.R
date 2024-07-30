devUI <- function() {
    addResourcePath(
      prefix = "dev",
      directoryPath = system.file("dev", 
                                  package = "shinyAppPkgs")
    )
  tagList(
    bslib::page_fillable(
      title = "Movie Reviews (ggplot2movies)",
      theme = bslib::bs_theme(
        bg = "#043b67",
        fg = "#ffffff",
        primary = "#ffcf22",
        secondary = "#38B44A",
        success = "#32E0C4",
        base_font = sass::font_google("Ubuntu"),
        heading_font = sass::font_google("Ubuntu")
      ),
      bslib::layout_sidebar(
        sidebar = bslib::sidebar(
          dev_mod_vars_ui("vars")
        ),
        bslib::card(
          full_screen = TRUE,
          bslib::card_header(
              tags$div(
                tags$img(
                  src = "dev/imdb.png",
                  height = 80,
                  width = 110,
                  style = "margin:10px 10px"
                )
              )
            ),
          bslib::card_body(
            dev_mod_scatter_ui("plot")
          )
        )
      )
    )
  )
}