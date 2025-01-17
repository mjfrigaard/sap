#' User Interface for the Movies Review Application
#'
#' Creates the user interface (UI) for the Movies Review application, which
#' allows users to create customizable scatter plots based on movie data.
#' 
#' @param bslib View bslib logo?
#'
#' @return A Shiny `tagList` object containing the UI elements.
#'
#' @section Details:
#' The interface is built using [`bslib`](https://rstudio.github.io/bslib/)
#' - **Page (fillable)**: [`bslib::page_fillable()`](https://rstudio.github.io/bslib/reference/page_fillable.html)
#'   displays the app title.
#' - **Sidebar**: [`bslib::layout_sidebar()`](https://rstudio.github.io/bslib/reference/sidebar.html)
#'   includes a logo and the variable
#'   selection module.
#'   ([`mod_var_input_ui`]).
#' - **Card**: [`bslib::card()`](https://rstudio.github.io/bslib/reference/card.html)
#'   displays the scatter plot module
#'   ([`mod_scatter_display_ui`]).
#'
#' @seealso
#' - [`movies_server()`] for the server logic of the app.
#' - [`mod_var_input_ui()`] and [`mod_scatter_display_ui()`] for the modules
#'   included in the UI.
#'
#' @family **Application Components**
#'
#' @examples
#' if (interactive()) {
#'   shiny::shinyApp(ui = movies_ui(), server = movies_server)
#' }
#'
#' 
#' @export
#' 
movies_ui <- function(bslib = FALSE) {
  addResourcePath(
    prefix = 'www', 
    directoryPath = system.file('www', package = 'sap'))
  if (isFALSE(bslib)) {
  tagList(
    bslib::page_fillable(
      h1("Movie Reviews"),
      bslib::layout_sidebar(
        sidebar =
          bslib::sidebar(
            title = tags$h4("Sidebar inputs"),
            img(
              src = "www/shiny.png",
              height = 60,
              width = 55,
              style = "margin:10px 10px"
            ),
            mod_var_input_ui("vars")
          ),
        bslib::card(
          full_screen = TRUE,
          bslib::card_header(
            tags$h4("Scatter Plot")
          ),
          bslib::card_body(fillable = TRUE,
            mod_scatter_display_ui("plot")
          ),
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
  )
  } else {
    tagList(
      bslib::page_fillable(
        title = "Movie Reviews (bslib)",
        theme = bslib::bs_theme(
          bg = "#101010",
          fg = "#F6F5F5",
          primary = "#EE6F57",
          secondary = "#32E0C4",
          success = "#FF4B5C",
          base_font = sass::font_google("Ubuntu"),
          heading_font = sass::font_google("Ubuntu")
        ),
        bslib::layout_sidebar(
          sidebar = bslib::sidebar(
            open = TRUE,
            mod_var_input_ui("vars")
          ),
          bslib::card(
            full_screen = TRUE,
                bslib::card_header(
                  img(src = "www/bootstrap.png",
                  height = 80,
                  width = 100,
                  style = "margin:10px 10px")
              ),
             bslib::card_body(fillable = TRUE,
                 mod_scatter_display_ui("plot")
            )
          )
        )
      )
    )
  }
} 
