#' User Interface for Raincloud Plots
#'
#' @param id Shiny module ID.
#'
#' @return A UI for displaying a rain cloud plot.
#' 
#' @section Outputs:
#' - `genre`: Vertical bar plot.
#'
#' @seealso [mod_raincloud_server()]
#' 
#' @export
#' 
mod_raincloud_ui <- function(id) {
  ns <- NS(id)
    tagList(
      # verbatimTextOutput(outputId = ns("cloud")),
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
#' @section Reactive Inputs:
#' - `vals`: Reactive list of plot parameters.
#'
#' @seealso [mod_raincloud_ui()]
#' 
#' @export
mod_raincloud_server <- function(id, vals) {
  moduleServer(id, function(input, output, session) {

      output$cloud <- renderPlot({
        req(vals())
        d_rc <- subset(shinyrPkgs::movies,
                       !is.na(as.character(vals()$num_var)) &
                       !is.na(as.character(vals()$chr_var)))
        a <- as.numeric(vals()$alpha)
        s <- as.numeric(vals()$size)
        gg2_box <- ggplot2::ggplot(d_rc,
            ggplot2::aes(x = !!vals()$num_var,
                         y = !!vals()$chr_var, )) +
          ggplot2::geom_boxplot(
            ggplot2::aes(fill = !!vals()$chr_var),
            width = 0.10,
            outlier.shape = NA,
            alpha = a,
            show.legend = FALSE)
        gg2_halfeye <- gg2_box +
          ggdist::stat_halfeye(
              ggplot2::aes(fill = !!vals()$chr_var),
                alpha = a,
                adjust = s/5, # shape = adjust * density estimator
                # adjust = 0.5, # shape = adjust * density estimator
                .width = 0, # can use probabilities or 0
                point_colour = NA, # removes the point in center
                orientation = "horizontal", # like the box plot
                height = 0.75, # height of curve
                justification = -0.20, # shift vertically above box
                show.legend = FALSE # don't need this
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
                  show.legend = FALSE)
        gg2_point + 
        ggplot2::labs(
          # title = vals()$title,
          # subtitle = vals()$subtitle,
          x = vals()$num_var,
          y = vals()$chr_var
        ) +
        ggplot2::theme_minimal() +
        ggplot2::theme(legend.position = "none")
      })
  
  })
}

# 
# ggplot2::ggplot(d_rc,
#     ggplot2::aes(x = runtime, 
#                  y = critics_rating)) + 
#   ggplot2::geom_boxplot(
#     ggplot2::aes(fill = critics_rating),
#     width = 0.10,
#     outlier.shape = NA,
#     alpha = 1/2,
#     show.legend = FALSE) +
#   ggdist::stat_halfeye(
#     ggplot2::aes(fill = critics_rating),
#       adjust = 0.5, # shape = adjust * density estimator
#       .width = 0, # can use probabilities or 0
#       point_colour = NA, # removes the point in center
#       orientation = "horizontal", # like the box plot
#       height = 0.5, # height of curve
#       justification = -0.20, # shift vertically above box
#       show.legend = FALSE # don't need this 
#     ) +
#   ggplot2::geom_point(
#     ggplot2::aes(fill = critics_rating),
#         position = ggplot2::position_jitter(
#           seed = 54321, 
#           height = .05),
#           shape = 21, 
#           color = "#ffffff", 
#           alpha = 1/4, 
#           size = 2.5,
#           show.legend = FALSE) 
