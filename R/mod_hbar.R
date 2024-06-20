#' User Interface for Horizontal Bar Plot
#'
#' @param id Shiny module ID.
#'
#' @return A UI for displaying a horizontal bar plot.
#' 
#' @section Outputs:
#' - `ratings`: Horizontal bar plot.
#'
#' @seealso [mod_hbar_server()]
#' 
#' @export
mod_hbar_ui <- function(id) {
  ns <- NS(id)
    tagList(
      plotOutput(outputId = ns("ratings"))
      # verbatimTextOutput(outputId = ns("ratings"))
    )
}

#' Server Logic for Horizontal Bar Plot
#'
#' @param id Shiny module ID.
#' @param vals Reactive list of plot parameters.
#'
#' @return Renders a horizontal bar plot based on selected parameters.
#' 
#' @section Reactive Inputs:
#' - `vals`: Reactive list of plot parameters.
#'
#' @seealso [mod_hbar_ui()]
#' 
#' @export
mod_hbar_server <- function(id, vals) {
  moduleServer(id, function(input, output, session) {
        
  output$ratings <- renderPlot({
      req(vals())
      tspan <- abs(vals()$start_year - vals()$end_year)
      t <- paste("Time span =", tspan, "years")
      x_lab <- title_labs(as.character(vals()$chr_var))
      d <- subset(movies, 
        thtr_rel_year >= vals()$start_year &
        thtr_rel_year <= vals()$end_year)
      drows <- nrow(d)
      s <- paste("Total movies = ", drows)
      ggplot2::ggplot(d,
        ggplot2::aes(x = 
            forcats::fct_rev(
              forcats::fct_infreq(
                !!vals()$chr_var
                )
              )
          )
        ) +
        ggplot2::geom_bar(
          ggplot2::aes(
            fill = !!vals()$chr_var
            ), show.legend = FALSE
        ) +
        ggplot2::coord_flip() + 
        ggplot2::labs(
          title = t,
          subtitle = s,
          x = x_lab,
          y = "# of Movies", 
          fill = x_lab
          ) +
        ggplot2::theme_minimal()
    })
  
  })
}
