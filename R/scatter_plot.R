#' Build a scatter plot
#'
#' @param df Data frame containing `x_var`, `y_var`, and `col_var`.
#' @param x_var Name of the column for the x aesthetic.
#' @param y_var Name of the column for the y aesthetic.
#' @param col_var Name of the column for the color aesthetic.
#' @param alpha_var Numeric alpha (transparency), 0-1.
#' @param size_var Numeric point size.
#'
#' @return A `ggplot` object.
scatter_plot <- function(df, x_var, y_var, col_var, alpha_var, size_var) {
  ggplot2::ggplot(data = df,
    ggplot2::aes(x = .data[[x_var]],
      y = .data[[y_var]],
      color = .data[[col_var]])) +
    ggplot2::geom_point(alpha = alpha_var, size = size_var)
}
