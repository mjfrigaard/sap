#' User Interface for Vertical Bar Plot
#'
#' @param id Shiny module ID.
#'
#' @return A UI for displaying a vertical bar plot.
#' 
#' @section Outputs:
#' - `genre`: Vertical bar plot.
#'
#' @seealso [mod_waffle_server()]
#' 
#' @export
#' 
mod_waffle_ui <- function(id) {
  ns <- NS(id)
    tagList(
      plotOutput(outputId = ns("genre"))
    )
}

#' Server Logic for Vertical Bar Plot
#'
#' @param id Shiny module ID.
#' @param vals Reactive list of plot parameters.
#'
#' @return Renders a vertical bar plot based on selected parameters.
#' 
#' @section Reactive Inputs:
#' - `vals`: Reactive list of plot parameters.
#'
#' @seealso [mod_waffle_ui()]
#' 
#' @export
mod_waffle_server <- function(id, vals) {
  moduleServer(id, function(input, output, session) {
    
    output$genre <- renderPlot({
      req(vals())
      tspan <- abs(vals()$start_year - vals()$end_year)
      x_lab <- name_case(as.character(vals()$chr_var))
      t <- paste("Time span =", tspan, "years")
      movies <- shinyrPkgs::movies
      # convert to character 
      movies$chr_var <- as.character(movies[[vals()$chr_var]])
      # subset
      d <- subset(movies, 
              thtr_rel_year >= vals()$start_year &
              thtr_rel_year <= vals()$end_year)
      drows <- nrow(d)
      s <- paste("Total movies = ", drows)
      # waffle iron
      d_iron <- ggwaffle::waffle_iron(d,
                            ggwaffle::aes_d(group = chr_var))
      # plot
      ggplot2::ggplot(data = d_iron, 
             ggplot2::aes(x = x, 
                 y = y, 
                 fill = group)) + 
        ggwaffle::geom_waffle() +
        ggplot2::labs(
          title = t,
          subtitle = s,
          x = "", y = "", 
          fill = x_lab
          ) + 
        ggplot2::theme(legend.position = "top") + 
        ggwaffle::theme_waffle()
    })

  })
}
