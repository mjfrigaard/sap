#' User Interface for Distribution Variable Selection
#'
#' @param id Shiny module ID.
#'
#' @return A UI for selecting variables and plot attributes.
#' 
#' @section Inputs:
#' - `num_var`: numeric variable.
#' - `chr_var`: group variable.
#' - `alpha`: Alpha transparency.
#' - `size`: Point size.
#'
#' @seealso [mod_dist_vars_server()]
#' 
#' @export
mod_dist_vars_ui <- function(id) {
  num_data <- movies[c("critics_score", "audience_score", "runtime", 
                       "imdb_rating")]
  rating_data <- movies[c("critics_rating", "audience_rating")]

  ns <- NS(id)
  tagList(
    varSelectInput(
      inputId = ns("chr_var"),
      label = a(strong("Y (Color/group variable)")),
      data = rating_data,
      selected = "critics_rating"
    ),
    varSelectInput(
      inputId = ns("num_var"),
      label = a(strong("X (Numeric variable)")),
      data = num_data,
      selected = "audience_score"
    ),
    markdown("**Customize**"),
    sliderInput(
      inputId = ns("alpha"),
      label = "Alpha",
      min = 0.2, 
      max = 1.0, 
      step = 0.2,
      value = 0.6
    ),
    sliderInput(
      inputId = ns("size"),
      label = "Size/scale",
      min = 1, 
      max = 6,
      step = 0.5,
      value = 3
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
#' - `num_var`: numeric variable.
#' - `chr_var`: group variable.
#' - `alpha`: Alpha transparency.
#' - `size`: Point size.
#'
#' @seealso [mod_dist_vars_ui()]
#' 
#' @export
mod_dist_vars_server <- function(id) {
  moduleServer(id, function(input, output, session) {
    return(
      reactive({
        list(
          "num_var" = input$num_var,
          "chr_var" = input$chr_var,
          "alpha" = input$alpha,
          "size" = input$size
        )
      })
    )
  })
}