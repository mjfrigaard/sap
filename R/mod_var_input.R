#' Variable Input Module - UI
#'
#' Creates a UI for selecting variables and attributes for a scatter plot.
#'
#' @param id *(character)* Namespace ID for the module.
#'
#' @return A `shiny::tagList()` containing UI elements for variable 
#' selection.
#'
#' @section Details: 
#' `mod_var_input_ui()` provides UI controls for customizing scatter plots. 
#'  It includes:  
#' - **Dropdowns**: 
#'   - X-axis variable
#'   - Y-axis variable
#'   - Color aesthetic variable
#' - **Sliders**:
#'   - Transparency (`alpha`) ranging from 0 to 1.
#'   - Point size ranging from 0 to 5.
#' - **Text Input**:
#'   - Plot title.
#'
#' The function uses `shiny::NS()` to namespace all input IDs.
#'
#' @seealso
#' - [`mod_var_input_server()`]  for server-side logic.
#' - [`shiny::tagList()`](https://shiny.rstudio.com/reference/shiny/latest/tagList.html) 
#'   for containing UI elements.
#' - [`shiny::NS()`](https://shiny.rstudio.com/reference/shiny/latest/NS.html) 
#'   for namespacing.
#'
#' @family **Variable Input Module**
#'
#' @examples
#'
#' if (interactive()) {
#'   shiny::shinyApp(
#'     ui = shiny::fluidPage(mod_var_input_ui("vars")),
#'     server = function(input, output, session) {
#'       selected_vars <- mod_var_input_server("vars")
#'       shiny::observe(
#'           print(selected_vars())
#'        )
#'     }
#'   )
#' }
#' 
#' @export
mod_var_input_ui <- function(id) {
  ns <- NS(id)
  tagList(
    selectInput(
      inputId = ns("y"),
      label = "Y-axis:",
      choices = c(
        "IMDB rating" = "imdb_rating",
        "IMDB number of votes" = "imdb_num_votes",
        "Critics Score" = "critics_score",
        "Audience Score" = "audience_score",
        "Runtime" = "runtime"
      ),
      selected = "audience_score"
    ),
    selectInput(
      inputId = ns("x"),
      label = "X-axis:",
      choices = c(
        "IMDB rating" = "imdb_rating",
        "IMDB number of votes" = "imdb_num_votes",
        "Critics Score" = "critics_score",
        "Audience Score" = "audience_score",
        "Runtime" = "runtime"
      ),
      selected = "imdb_rating"
    ),
    selectInput(
      inputId = ns("z"),
      label = "Color by:",
      choices = c(
        "Title Type" = "title_type",
        "Genre" = "genre",
        "MPAA Rating" = "mpaa_rating",
        "Critics Rating" = "critics_rating",
        "Audience Rating" = "audience_rating"
      ),
      selected = "mpaa_rating"
    ),
    sliderInput(
      inputId = ns("alpha"),
      label = "Alpha:",
      min = 0, max = 1, step = 0.1,
      value = 0.5
    ),
    sliderInput(
      inputId = ns("size"),
      label = "Size:",
      min = 0, max = 5,
      value = 2
    ),
    textInput(
      inputId = ns("plot_title"),
      label = "Plot title",
      placeholder = "Enter plot title"
    )
  )
}

#' Variable Input Module - Server
#'
#' Handles the server-side logic for the variable input module.
#'
#' @param id *(character)* Namespace ID for the module.
#'
#' @return A **reactive expression** that returns a list of selected input
#'   values:  
#' - `y`: Variable for the y-axis.
#' - `x`: Variable for the x-axis.
#' - `z`: Variable for the color aesthetic.
#' - `alpha`: Transparency level of points (0-1).
#' - `size`: Size of the points.
#' - `plot_title`: Title for the scatter plot.
#'
#' @section Details: 
#' `mod_var_input_server()` reads user input from the corresponding UI 
#'  function created with 
#' `mod_var_input_ui()`. It processes and returns a reactive object 
#'  containing the selected variables and plot attributes.
#'
#' @seealso
#' - [`mod_var_input_ui()`] for the UI counterpart of this module.
#' - [`mod_scatter_display_server()`] for displaying the scatter plot.
#'
#' @family **Variable Input Module**
#'
#' if (interactive()) {
#'   shiny::shinyApp(
#'     ui = shiny::fluidPage(mod_var_input_ui("vars")),
#'     server = function(input, output, session) {
#'       selected_vars <- mod_var_input_server("vars")
#'       shiny::observe(print(selected_vars()))
#'     }
#'   )
#' }
#' 
#' @export
mod_var_input_server <- function(id) {

  moduleServer(id, function(input, output, session) {
    return(
      reactive({
        list(
          "y" = input$y,
          "x" = input$x,
          "z" = input$z,
          "alpha" = input$alpha,
          "size" = input$size,
          "plot_title" = input$plot_title
        )
      })
    )
  })
}
