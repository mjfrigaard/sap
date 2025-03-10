#' Create a Plotly Scatter Plot
#'
#' The `scatter_plotly()` function generates an interactive Plotly
#' scatter plot using a reactive dataset.
#' The user specifies the x-axis, y-axis, and a categorical variable for
#' coloring the points.
#'
#' @param data A reactive expression that returns a `tibble` or `data.frame`
#' containing the data.
#' @param xvar A reactive expression specifying the column name for the x-axis
#' variable.
#' @param yvar A reactive expression specifying the column name for the y-axis
#' variable.
#' @param colvar A character string specifying the column name for the
#' categorical variable used for coloring points.
#'
#' @return A `plotly` object representing the scatter plot.
#'
#' @export
#'
scatter_plotly <- function(data, xvar, yvar, colvar) {

  # check column names exist
  if (!all(c(xvar, yvar, colvar) %in% names(data))) {
    stop("One or more specified columns do not exist in the dataset.")
  }

  # convert to factor (for consistent coloring)
  data[[colvar]] <- as.factor(data[[colvar]])

  plotly::plot_ly(
    data = data,
    x = ~ .data[[xvar]],
    y = ~ .data[[yvar]],
    color = ~ .data[[colvar]],
    type = 'scatter',
    mode = 'markers',
    marker = list(size = 8, opacity = 0.6)
  ) |>
    plotly::layout(
      title = tools::toTitleCase(paste("Scatter Plot of", xvar, "vs", yvar)),
      xaxis = list(title = tools::toTitleCase(xvar)),
      yaxis = list(title = tools::toTitleCase(yvar)),
      legend = list(title = list(text = colvar))
    )
}
