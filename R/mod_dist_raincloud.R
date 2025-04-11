#' User Interface for Raincloud Plots
#'
#' @param id Shiny module ID.
#'
#' @return A UI for displaying a rain cloud plot.
#' 
#' @export
#' 
mod_dist_raincloud_ui <- function(id) {
  ns <- NS(id)
    tagList(
      # verbatimTextOutput(outputId = ns("dev")),
      plotOutput(outputId = ns("cloud"))
    )
}

#' Server Logic for Raincloud Plot
#'
#' @param id Shiny module ID.
#' @param vals Reactive list of plot parameters.
#'
#' @return Renders a horizontal bar plot based on selected parameters.
#' 
#' @export
#' 
mod_dist_raincloud_server <- function(id, vals) {
  moduleServer(id, function(input, output, session) {

    # output$dev <- renderPrint({
    #   req(vals())
    #   str(vals())
    #   d_rc <- subset(sap::movies,
    #                  !is.na(as.character(vals()$num_var)) &
    #                  !is.na(as.character(vals()$chr_var)))
    #   str(d_rc)
    # })

    output$cloud <- renderPlot({
      # observe({
      #   browser()

      req(vals())
      # pretty names 
      mv_nms <- names(sap::movies) |> name_case()
      movie_data <- setNames(object = sap::movies, nm = mv_nms)
      
      a <- as.numeric(vals()$alpha)
      s <- as.numeric(vals()$size)

      gg2_box <- ggplot2::ggplot(movie_data,
          ggplot2::aes(x = !!vals()$num_var,
                       y = !!vals()$chr_var)) +
        ggplot2::geom_boxplot(
          ggplot2::aes(fill = !!vals()$chr_var),
          width = 0.10,
          outlier.shape = NA,
          alpha = a,
          show.legend = FALSE
        ) +
        ggplot2::scale_fill_manual(values = clr_pal12)
        
      gg2_halfeye <- gg2_box +
        ggdist::stat_halfeye(
          ggplot2::aes(fill = !!vals()$chr_var),
          alpha = a,
          adjust = s/5, 
          .width = 0, 
          point_colour = NA, 
          orientation = "horizontal", 
          height = 0.75, 
          justification = -0.20, 
          show.legend = FALSE 
        )

      gg2_point <- gg2_halfeye +
        ggplot2::geom_point(
          ggplot2::aes(
            fill = !!vals()$chr_var),
            position = 
            ggplot2::position_jitter(
              seed = 54321,
              height = .05),
            shape = 21,
            color = "#ffffff",
            alpha = a,
            size = 3,
            show.legend = FALSE
        )

        gg2_point + 
          ggplot2::labs(
            x = name_case(as.character(vals()$num_var)),
            y = name_case(as.character(vals()$chr_var))
          ) +
          ggplot2::theme(
            legend.position = "none",
            axis.text = ggplot2::element_text(color = "#ffffff"),
            axis.title = ggplot2::element_text(color = "#ffffff")
          )
        
      # })
        
      })

    })

}
      

      



