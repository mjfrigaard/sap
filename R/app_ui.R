#' The application User-Interface
#'
#' @param request Internal parameter for `{shiny}`.
#'     DO NOT REMOVE.
#'     
#' @import shiny
#' 
#' @noRd
#' 
app_ui <- function(request) {
  tagList(
    # Leave this function for adding external resources
    golem_add_external_resources(),
    # Your application UI logic
    thematic::thematic_shiny(),
    tagList(
      bslib::page_fillable(
        title = "Movie Reviews (bslib)",
        theme = gap_theme,
        bslib::layout_sidebar(
          sidebar = bslib::sidebar(
            mod_var_inputs_ui("vars"),
            mod_aes_inputs_ui("aes")
          ),
          bslib::card(
            full_screen = TRUE,
            bslib::card_header(h4(em("Brought to you by ",
              tags$img(
                src = "www/golem.png",
                height = 100,
                width = 100,
                style = "margin:10px 10px"
              )))
            ),
            bslib::card_body(
              mod_scatter_display_ui("plot")
            )
          )
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
#' @import shiny
#' @importFrom golem add_resource_path activate_js favicon bundle_resources
#' @noRd
golem_add_external_resources <- function() {
  add_resource_path(
    "www",
    app_sys("app/www")
  )
  tags$head(
    favicon(),
    bundle_resources(
      path = app_sys("app/www"),
      app_title = "gap"
    ),
    # Add here other external resources
    # for example, you can add shinyalert::useShinyalert()
    bslib::bs_theme_dependencies(theme = gap_theme)
  )
}
