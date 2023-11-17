#' Movies UI function
#' 
#' UI function for standalone app function 
#' 
#' @usage NULL
#' 
#' @param bslib use `bslib` layout?
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
movies_ui <- function(bslib = FALSE) {
  addResourcePath(
    prefix = 'www',
    directoryPath = system.file('www', package = 'moviesApp'))
  if (isFALSE(bslib)) {
  tagList(
    fluidPage(
      theme = shinythemes::shinytheme("spacelab"),
      titlePanel(
        div(
          img(
            src = "www/shiny.png",
            height = 60,
            width = 55,
            style = "margin:10px 10px"
            ),
         "Movie Reviews"
        )
      ),
      sidebarLayout(
        sidebarPanel(
          mod_var_input_ui("vars"),
        ),
        mainPanel(
          text_logo(),
          mod_scatter_display_ui("plot"),
          super_text_logo()
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
            mod_var_input_ui("vars"),
            text_logo(size = 'h5')
          ),
          bslib::card(
            full_screen = TRUE,
                bslib::card_header(
                  tags$img(
                  src = "www/bootstrap.png",
                  height = 80,
                  width = 100,
                  style = "margin:10px 10px"
                )
              ),
             bslib::card_body(
               div(
                 mod_scatter_display_ui("plot") 
              )
            )
          )
        )
      )
    )
  }
} 
