#' User Interface for Distribution Variable Selection
#'
#' @param id Shiny module ID.
#'
#' @return A UI for selecting variables and plot attributes.
#' 
#' @export
mod_dist_vars_ui <- function(id) {
  num_data <- movies[c("critics_score", "audience_score", "runtime", 
                       "imdb_rating")]
  num_nms <- names(num_data) |> name_case()
  num_data <- setNames(num_data, num_nms)
  
  rating_data <- movies[c("critics_rating", "audience_rating")]
  rating_nms <- names(rating_data) |> name_case()
  rating_data <- setNames(rating_data, rating_nms)

  ns <- NS(id)
  tagList(
    varSelectInput(
      inputId = ns("chr_var"),
      label = a(strong("Y (Color/group variable)")),
      data = rating_data,
      selected = "Critics Rating"
    ),
    varSelectInput(
      inputId = ns("num_var"),
      label = a(strong("X (Numeric variable)")),
      data = num_data,
      selected = "Audience Score"
    ),
    markdown("**Customize**"),
    sliderInput(
      inputId = ns("alpha"),
      label = "Alpha",
      min = 0.2, 
      max = 1.0, 
      step = 0.2,
      value = 0.8
    ),
    sliderInput(
      inputId = ns("size"),
      label = "Size/scale",
      min = 1, 
      max = 5,
      step = 0.5,
      value = 3.0
    )
  )
}

#' Server Logic for Variable Selection
#'
#' @param id Shiny module ID.
#'
#' @return A reactive list of selected variables and plot attributes.
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