#' Create a Scatter Plot with Custom Axes and Color
#'
#' Generates a `ggplot2` scatter plot from a data frame using variable names
#' supplied as strings for the x-axis, y-axis, and color aesthetic. This allows
#' for dynamic plotting in Shiny apps or other interactive environments.
#'
#' @param df A data frame or tibble containing the variables to be plotted.
#' @param x_var A string. The name of the variable to map to the x-axis.
#' @param y_var A string. The name of the variable to map to the y-axis.
#' @param col_var A string. The name of the variable to use for point color.
#'
#' @return A `ggplot` object representing the scatter plot.
#'
#' @examples
#' scatter_plot(mtcars, "mpg", "hp", "cyl")
#'
#' @importFrom rlang .data
#' 
#' @export
scatter_plot <- function(df, x_var, y_var, col_var) {
  ggplot2::ggplot(data = df, 
    ggplot2::aes(x = .data[[x_var]], 
                 y = .data[[y_var]], 
                color = .data[[col_var]])) +
    ggplot2::geom_point(alpha = 0.6) +
    ggplot2::labs(x = x_var, y = y_var, color = col_var) +
    ggplot2::theme_minimal()
}