#' User Interface for the Movies Review Application
#'
#' Creates the user interface (UI) for the Movies Review application, which
#' allows users to create customizable scatter plots based on movie data.
#'
#' @return A `bslib::page_sidebar()` UI object.
#'
#' @section Details:
#' The interface is built using:
#' - **Theme**: `bslib::bs_theme(bootswatch = "spacelab")`.
#' - **Title**: Displays the app title and a logo.
#' - **Sidebar**: Includes the variable selection module
#'   ([`mod_var_input_ui`]).
#' - **Main area**: Displays the scatter plot module
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
movies_ui <- function() {
  bslib::page_sidebar(
    title = div(
      img(
        src = "shiny.png",
        height = 60,
        width = 55,
        style = "margin:10px 10px"
      ),
      "Movie Reviews"
    ),
    theme = bslib::bs_theme(bootswatch = "spacelab"),
    sidebar = bslib::sidebar(
      mod_var_input_ui("vars")
    ),
    mod_scatter_display_ui("plot")
  )
}
