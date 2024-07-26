#' Movies UI function
#' 
#' UI function for standalone app function 
#' 
#' @usage NULL
#' 
#' @param bslib use bslib layout?
#' 
#' @details
#' The [launch_app()] function is as a wrapper for `shinyApp()`: 
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
#' @return `ui` argument in `shinyApp()` 
#' 
#' @export
#' 
movies_ui <- function(bslib = FALSE) {
  addResourcePath(
    prefix = 'www',
    directoryPath = system.file('www', package = 'shinyAppPkgs'))
  if (isFALSE(bslib)) {
  tagList(
    bslib::page_fillable(
      h1("Movie Reviews"),
      bslib::layout_sidebar(
        sidebar =
          bslib::sidebar(
            title = tags$h4("Sidebar inputs"),
            img(
              src = "www/shiny.png",
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
          bslib::card_body(
            mod_scatter_display_ui("plot")
          ),
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
            mod_var_input_ui("vars")
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
              mod_scatter_display_ui("plot")
            )
          )
        )
      )
    )
  }
} 
