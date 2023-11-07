#' Create scatter plot 
#'
#' Custom [`ggplot2`](https://ggplot2.tidyverse.org/) function for building scatter plots in `moviesApp()`.
#' 
#' 
#' @param df `data.frame` or `tibble`
#' @param x_var string variable mapped to `x` axis
#' @param y_var string variable mapped to `y` axis
#' @param col_var string variable mapped to `color`
#' @param alpha_var number for point `alpha`
#' @param size_var number for point `size` 
#' 
#' @return A `ggplot2` plot object
#' 
#' 
#' @examples
#' scatter_plot(mtcars, 
#'     x_var = "mpg", 
#'     y_var = "disp", 
#'     col_var = "cyl", 
#'     alpha_var = 0.5, 
#'     size_var = 3)
#'     
#' @seealso [mod_scatter_display_server()]
#' 
#' @importFrom rlang .data
#' 
#' @export
scatter_plot <- function(df, x_var, y_var, col_var, alpha_var, size_var) {
    ggplot2::ggplot(data = df,
      ggplot2::aes(x = .data[[x_var]],
          y = .data[[y_var]],
          color = .data[[col_var]])) +
      ggplot2::geom_point(alpha = alpha_var, size = size_var)

}