#' User Interface for Vertical Bar Plot
#'
#' @param id Shiny module ID.
#'
#' @return A UI for displaying a vertical bar plot.
#' 
#' @section Outputs:
#' - `waffle_plot`: Vertical bar plot.
#'
#' @seealso [mod_waffle_server()]
#' 
#' @export
#' 
mod_waffle_ui <- function(id) {
  ns <- NS(id)
    tagList(
      plotOutput(outputId = ns("waffle_plot"))
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

  output$waffle_plot <- renderPlot({
    req(vals())
    x_lab <- name_case(as.character(vals()$chr_var))
    movies <- shinyrPkgs::movies
    # convert to character 
    movies$chr_var <- as.character(movies[[vals()$chr_var]])
    # subset
    d <- subset(movies, 
            thtr_rel_year >= vals()$start_year &
            thtr_rel_year <= vals()$end_year)
    # waffle iron
    d_iron <- ggwaffle::waffle_iron(d,
                          ggwaffle::aes_d(group = chr_var))
    # plot
    ggplot2::ggplot(data = d_iron, 
           ggplot2::aes(x = x, 
               y = y, 
               fill = group)) + 
      ggwaffle::geom_waffle() +
      ggplot2::scale_fill_manual(values = clr_pal12) +  
      ggplot2::labs(
        x = "", y = "", 
        fill = x_lab
      ) + 
      ggplot2::theme(
          legend.position = "top", 
          legend.text = ggplot2::element_text(color = "#ffffff", size = 14),
          title = ggplot2::element_text(color = "#ffffff", size = 16),
          panel.grid.major = ggplot2::element_blank(),
          panel.grid.minor = ggplot2::element_blank(),
          axis.ticks = ggplot2::element_blank(),
          axis.text = ggplot2::element_blank(),
          axis.title = ggplot2::element_blank()
    ) 
  })

  })
}
