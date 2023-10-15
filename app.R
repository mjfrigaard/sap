# install ------------------------------------
# after installing, comment this out
# pkgs <- c("shiny", "shinythemes", "stringr", "ggplot2", "rlang")
# install.packages(pkgs, verbose = FALSE)

# packages ------------------------------------
library(shiny)
library(shinythemes)
library(stringr)
library(ggplot2)
library(rlang)

movies_app <- function() {
  shiny::shinyApp(
    ui = shiny::fluidPage(
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
    ),
    server = function(input, output, session) {
      selected_vars <- mod_var_input_server("vars")

      mod_scatter_display_server("plot", var_inputs = selected_vars)
    }
  )
}
movies_app()
