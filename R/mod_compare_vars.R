#' User Interface for Variable Selection
#'
#' @param id Shiny module ID.
#'
#' @return A UI for selecting variables and plot attributes.
#' 
#' @export
mod_compare_vars_ui <- function(id) {

  num_vars <- movies[c("runtime", "imdb_rating",
                       "imdb_num_votes", "critics_score",
                        "audience_score")]
  
  num_nms <- names(num_vars) |> name_case()
  num_data <- setNames(object = num_vars, nm = num_nms)
  
  chr_vars <- movies[c("mpaa_rating", "genre", "critics_rating")]
  chr_nms <- names(chr_vars) |> name_case()
  chr_data <- setNames(object = chr_vars, nm = chr_nms)

  ns <- NS(id)
  tagList(
    varSelectInput(
      inputId = ns("var_x"),
      label = strong("X variable"),
      data = num_data,
      selected = "Imdb Rating"
    ),
    varSelectInput(
      inputId = ns("var_y"),
      label = strong("Y variable"),
      data = num_data,
      selected = "Audience Score"
    ),
    varSelectInput(
      inputId = ns("color"),
      label = strong("Color by:"),
      data = chr_data,
      selected = "Critics Rating"
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
      num_cols <- name_case(c("audience_score", "critics_score", "imdb_num_votes",
                    "imdb_rating", "runtime"))
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
