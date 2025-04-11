#' User Interface for Distribution Data Table
#'
#' @param id Shiny module ID.
#'
#' @return A UI for displaying a data table.
#' 
#' @export
mod_dist_tbl_ui <- function(id) {
  ns <- NS(id)
    tagList(
      reactable::reactableOutput(
        outputId = ns("dist_table"))
    )
}

#' Server Logic for Distribution Data Table
#'
#' @param id Shiny module ID.
#' @param vals Reactive list of table parameters.
#'
#' @return Renders a data table based on selected parameters.
#' 
#' @export
mod_dist_tbl_server <- function(id, vals) {
  moduleServer(id, function(input, output, session) {
    
    output$dist_table <- reactable::renderReactable({
      req(vals())
      # pretty names 
      mv_nms <- names(sap::movies) |> name_case()
      movie_data <- setNames(object = sap::movies, nm = mv_nms)

      chr_var <- as.character(vals()$chr_var)
      num_var <- as.character(vals()$num_var)
      tbl_data <- dist_var_summary(data = movie_data, 
                                   chr_var, num_var)
      # normalize names
      reactable::reactable(data = tbl_data,
        borderless = TRUE,
        compact = TRUE,
        highlight = TRUE,
        striped = TRUE,
        style = list(
          backgroundColor = "#121212",
          color = "#ffffff"
        )
        # theme = reactable::reactableTheme(
        #   headerStyle = list(
        #     backgroundColor = "#121212",
        #     color = "#ffffff",
        #     borderColor = "#2979ff"
        #   ),
        #   rowStyle = list(
        #     backgroundColor = "#121212",
        #     color = "#ffffff"
        #   ),
        #   borderColor = "#2979ff"
        # )
      )
    })

  })
}
