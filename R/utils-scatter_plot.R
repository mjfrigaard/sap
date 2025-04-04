#' The scatter plot utility function
#'
#' @description A custom graphing ggplot2 function
#'
#' @return The return value, if any, from executing the utility.
#'
#' @param df `data.frame` or `tibble`
#' @param x_var string variable mapped to `x` axis
#' @param y_var string variable mapped to `y` axis
#'
#'
#' @importFrom rlang .data
#'
#' @export
#'
scatter_plot <- function(df, x_var, y_var, col_var, alpha_var, size_var) {
    ggplot2::ggplot(data = df,
      ggplot2::aes(x = .data[[x_var]],
          y = .data[[y_var]],
          color = .data[[col_var]])) +
      ggplot2::geom_point(alpha = alpha_var, size = size_var)
}
