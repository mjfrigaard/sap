#' User Interface for Vertical Bar Plot
#'
#' @param id Shiny module ID.
#'
#' @return A UI for displaying a vertical bar plot.
#' 
#' @export
#' 
mod_counts_waffle_ui <- function(id) {
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
#' @export
mod_counts_waffle_server <- function(id, vals) {
  moduleServer(id, function(input, output, session) {



  output$waffle_plot <- renderPlot({

    req(vals())
    x_lab <- name_case(as.character(vals()$chr_var))
    movies <- sap::movies
    # subset
    waffle_set <- subset(movies, 
            thtr_rel_year >= vals()$start_year &
            thtr_rel_year <= vals()$end_year)
    # clean names 
    nms_set <- names(waffle_set) |> name_case()
    movie_vars <- setNames(object = waffle_set, nm = nms_set)
    movie_vars$chr_var <- as.character(movie_vars[[vals()$chr_var]])
    # waffle iron
    movies_iron <- ggwaffle::waffle_iron(movie_vars,
                          ggwaffle::aes_d(group = chr_var))
    # plot
    ggplot2::ggplot(data = movies_iron, 
           ggplot2::aes(x = x, 
               y = y, 
               fill = group)) + 
      ggwaffle::geom_waffle() +
      ggplot2::scale_fill_manual(values = clr_pal12) +  
      ggplot2::labs(
        x = "", y = "", 
        fill = x_lab
      ) + 
      ggwaffle::theme_waffle() +
      ggplot2::theme( 
          legend.text = ggplot2::element_text(color = "#ffffff", size = 14),
          legend.title = ggplot2::element_text(color = "#ffffff", size = 16)
    ) 

    })
    
  })
}
