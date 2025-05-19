#' Create an Interactive Scatter Plot for Comparing Variables
#'
#' This function creates an interactive scatter plot using plotly to compare two
#' variables with points colored by a third variable.
#'
#' @param data A data frame containing the variables to plot
#' @param x Character string with the name of the variable to plot on the x-axis
#' @param y Character string with the name of the variable to plot on the y-axis
#' @param color Character string with the name of the variable to use for 
#'    coloring points
#' @param size Numeric value for the size of the points (default: 5)
#' @param alpha Numeric value for the transparency of the points (default: 0.7)
#' @param title Character string for the plot title. If NULL, a default title is
#'     generated
#'
#' @return A plotly interactive scatter plot object
#'
#' @examples
#' require(webshot)
#' compare_plot(movies, 
#'              "imdb_rating", "critics_score", "genre", 
#'               size = 7, alpha = 0.75, "Plot Title")
#'
#' @export
#' 
compare_plot <- function(data, x, y, color, size = 5, alpha = 0.7, title = NULL) {
  # title if not provided
  if (is.null(title)) {
    title <- paste(name_case(x), "vs.", name_case(y))
  }

  # plot
  plot <- plotly::plot_ly(
    data = data,
    x = ~get(x),
    y = ~get(y),
    color = ~get(color),
    text = ~title,
    type = "scatter",
    mode = "markers",
    colors = clr_pal3,
    marker = list(
      size = size,
      opacity = alpha
    )
  ) |>
    # title 
    plotly::layout(
      title = list(
        text = title,
        font = list(color = "#e0e0e0")
      ),
      # x-label 
      xaxis = list(
        title = name_case(x),
        titlefont = list(color = "#e0e0e0"),
        tickfont = list(color = "#e0e0e0")
      ),
      # y-label 
      yaxis = list(
        title = name_case(y),
        titlefont = list(color = "#e0e0e0"),
        tickfont = list(color = "#e0e0e0")
      ),
      # legend 
      legend = list(
        font = list(color = "#e0e0e0")
      ),
      # background color
      plot_bgcolor = "#121212",
      paper_bgcolor = "#121212"
    )
  return(plot)
}