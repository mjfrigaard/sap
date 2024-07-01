#' Movies UI function
#' 
#' UI function for standalone app function 
#' 
#' @usage NULL
#' 
#' @details
#' The [launch_app()] function is as a wrapper for `shiny::shinyApp()`: 
#'  
#' ```
#' shinyApp(ui = movies_ui, server = movies_server)
#' ```
#' 
#' In [launch_app()]:
#'  * UI is stored in `movies_ui()`    
#'  * server is stored in [movies_server()]
#'  
#' @section `var_input` module: 
#' [mod_var_input_ui()] is used to collect the following inputs:
#'  * `input$x`
#'  * `input$y`
#'  * `input$z`
#'  * `input$alpha`
#'  * `input$size`
#'  * `input$plot_title`
#'  
#' @seealso [mod_var_input_server()]
#' 
#' 
#' @section `scatter_display` module: 
#' [mod_scatter_display_ui()] displays the graph output using [scatter_plot()]
#' 
#' @seealso [mod_scatter_display_server()]
#'
#' @return `ui` argument in `shiny::shinyApp()` 
#' 
movies_ui <- function() {
  shiny::tagList(
    shiny::fluidPage(
      theme = shinythemes::shinytheme("spacelab"),
      shiny::titlePanel(
        shiny::div(
          shiny::img(
            src = "shiny.png",
            height = 60,
            width = 55,
            style = "margin:10px 10px"
            ), 
         "Movie Reviews"
        )
      ),
      shiny::sidebarLayout(
        shiny::sidebarPanel(
          mod_var_input_ui("vars")
        ),
        shiny::mainPanel(
          mod_scatter_display_ui("plot")
        )
      )
    )
  )
} 
