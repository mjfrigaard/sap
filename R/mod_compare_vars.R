#' User Interface for Variable Selection
#'
#' @param id Shiny module ID.
#'
#' @return A UI for selecting variables and plot attributes.
#' 
#' @section Inputs:
#' - `var_x`: X variable.
#' - `var_y`: Y variable.
#' - `color`: Color variable.
#' - `alpha`: Alpha transparency.
#' - `size`: Point size.
#' - `plot_title`: Plot title.
#'
#' @seealso [mod_compare_vars_server()]
#' 
#' @export
mod_compare_vars_ui <- function(id) {
  num_data <- movies[c("runtime", "imdb_rating",
                       "imdb_num_votes", "critics_score",
                        "audience_score")]
  chr_data <- movies[c("mpaa_rating", "genre", "critics_rating")]

  ns <- NS(id)
  tagList(
    varSelectInput(
      inputId = ns("var_x"),
      label = strong("X variable"),
      data = num_data,
      selected = "imdb_rating"
    ),
    varSelectInput(
      inputId = ns("var_y"),
      label = strong("Y variable"),
      data = num_data,
      selected = "audience_score"
    ),
    varSelectInput(
      inputId = ns("color"),
      label = strong("Color by:"),
      data = chr_data,
      selected = "critics_rating"
    ),
    sliderInput(
      inputId = ns("alpha"),
      label = strong("Alpha"),
      min = 0.5, 
      max = 1.0, 
      step = 0.1,
      value = 0.7
    ),
    sliderInput(
      inputId = ns("size"),
      label = strong("Size"),
      min = 5, 
      max = 10,
      step = 0.5,
      value = 7
    ),
    textInput(
      inputId = ns("plot_title"),
      label = strong("Plot title"),
      placeholder = "Enter plot title"
    )
  )
}

#' Server Logic for Variable Selection
#'
#' @param id Shiny module ID.
#'
#' @return A reactive list of selected variables and plot attributes.
#' 
#' @section Reactive Values:
#' - `x`: X variable.
#' - `y`: Y variable.
#' - `c`: Color variable.
#' - `a`: Alpha transparency.
#' - `s`: Point size.
#' - `t`: Plot title.
#'
#' @seealso [mod_compare_vars_ui()]
#' 
#' @export
mod_compare_vars_server <- function(id) {
  moduleServer(id, function(input, output, session) {
    
    observe({
      if (input$var_y == input$var_x) {
      num_cols <- c("audience_score", "critics_score", "imdb_num_votes", 
                    "imdb_rating", "runtime")
      y_cols <- num_cols[num_cols != input$var_x]
        updateSelectInput(
          session = session, 
          inputId = "var_y", 
          choices = y_cols, 
          selected = y_cols[1]) 
      }
    }) |> 
      bindEvent(input$var_x)
    
   observe({
     if (input$var_y == input$var_x) {
      num_cols <- c("audience_score", "critics_score", "imdb_num_votes",
                    "imdb_rating", "runtime")
      x_cols <- num_cols[num_cols != input$var_y]
        updateSelectInput(
          session = session,
          inputId = "var_x",
          choices = x_cols,
          selected = x_cols[1])
     }
    }) |>
      bindEvent(input$var_y)
    
    return(
      reactive({
        list(
          "x" = input$var_x,
          "y" = input$var_y,
          "color" = input$color,
          "alpha" = input$alpha,
          "size" = input$size,
          "title" = input$plot_title
        )
      })
    )
  })
}
