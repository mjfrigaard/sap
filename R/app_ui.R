#' The application User-Interface
#'
#' @param request Internal parameter for `{shiny}`.
#'     DO NOT REMOVE.
#'
#' @keywords internal
app_ui <- function(request) {
  tagList(
    # Leave this function for adding external resources
    golem_add_external_resources(),
    # Your application UI logic
    fluidPage(
      sidebarLayout(
        sidebarPanel(
          mod_var_ui("vars"),
          h6(
            img(src = "www/images/shiny.png", width = "15%"),
            em(
              "The data for this application comes from the ",
              a("Building web applications with Shiny",
                href = "https://rstudio-education.github.io/shiny-course/"
              ),
              "tutorial"
            )
          )
        ),
        mainPanel(
          fluidRow(
            br(),
            p(em("Brought to you by: "),
              # add golem hex (in www/images/)
              img(src = "www/images/golem-hex.png", width = "5%")
            )
          ),
          mod_plot_ui("plot")
        )
      )
    )
  )
}

#' Add external Resources to the Application
#'
#' This function is internally used to add external
#' resources inside the Shiny application.
#'
#'
#' @keywords internal
golem_add_external_resources <- function() {
  golem::add_resource_path(
    "www",
    app_sys("app/www")
  )
  tags$head(
    golem::favicon(),
    golem::bundle_resources(
      path = app_sys("app/www"),
      app_title = "gap"
    )
    # Add here other external resources
    # for example, you can add shinyalert::useShinyalert()
  )
}
