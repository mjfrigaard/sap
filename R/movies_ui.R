#' Movies UI function
#' 
#' UI function for standalone app function 
#' 
#' @usage NULL
#' 
#' @details
#' The [movies_app()] function is as a wrapper for `shinyApp()`: 
#'  
#' ```
#' shinyApp(ui = movies_ui, server = movies_server)
#' ```
#' 
#' In [movies_app()]:
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
#' @return `ui` argument in `shinyApp()` 
#' 
#' @export
#' 
movies_ui <- function() {
  tagList(
    bslib::page_fillable(
      h1("Movie Reviews"),
      bslib::layout_sidebar(
        sidebar =
          bslib::sidebar(
            title = tags$h4("Sidebar inputs"),
            img(
              src = "shiny.png",
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
          mod_scatter_display_ui("plot"),
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
}