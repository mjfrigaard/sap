#' User Interface for Count Tab Input
#'
#' @param id Shiny module ID.
#'
#' @return A UI for selecting a numeric input.
#' 
#' @export
#' 
mod_counts_vars_ui <- function(id) {
  # define variables 
  chr_vars <- movies[c("genre", "title_type", "mpaa_rating", 
                       "critics_rating", "audience_rating")]
  chr_nms <- names(chr_vars) |> name_case()
  chr_data <- setNames(object = chr_vars, nm = chr_nms)
  
  ns <- NS(id)
    tagList(
        varSelectInput(
          inputId = ns("chr_var"),
          label = strong("Group variable"),
          data = chr_data,
          selected = "Critics Rating"
        ),
        markdown("**Theater Release Year**"),
        numericInput(
        inputId = ns("start_year"),
        label = "Start",
        value = 1980,
        min = min(movies[["thtr_rel_year"]]),
        max = max(movies[["thtr_rel_year"]]),
        step = 1
      ),
        numericInput(
        inputId = ns("end_year"),
        label = "End",
        value = 1990,
        min = min(movies[["thtr_rel_year"]]),
        max = max(movies[["thtr_rel_year"]]),
        step = 1
      )
    )
}

#' Server Logic for Count Tab Input
#'
#' @param id Shiny module ID.
#'
#' @return A reactive list containing the selected year.
#' 
#' @export
#' 
mod_counts_vars_server <- function(id) {
  moduleServer(id, function(input, output, session) {
    
    observe({
      if (input$start_year >= input$end_year) {
        updateNumericInput(
          session = session, 
          inputId = "end_year", 
          value = input$start_year + 1)
      }
    }) |> 
      bindEvent(input$start_year)
    
    observe({
      if (input$end_year <= input$start_year) {
        updateNumericInput(
          session = session, 
          inputId = "start_year", 
          value = input$end_year - 1)
      }
    }) |> 
      bindEvent(input$end_year)
    
    return(
      reactive({
        req({nchar(input$start_year) == 4 & 
             nchar(input$end_year) == 4})
        list(
          "start_year" = input$start_year,
          "end_year" = input$end_year,
          "chr_var" = input$chr_var
        )
      })
    )
  })
}
