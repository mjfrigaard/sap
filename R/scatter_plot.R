#' Create scatter plot 
#'
#' Custom [`ggplot2`](https://ggplot2.tidyverse.org/) function for building 
#' scatter plots in `sap`.
#' 
#' 
#' @param df `data.frame` or `tibble`
#' @param x_var string variable mapped to `x` axis
#' @param y_var string variable mapped to `y` axis
#' Generate a Scatter Plot
#'
#' Creates a scatter plot using `ggplot2` with the specified data and 
#' aesthetics.
#'
#' @param df *(data.frame)* The dataset containing the variables to plot.
#' @param x_var *(character)* Name of the variable for the x-axis.
#' @param y_var *(character)* Name of the variable for the y-axis.
#' @param col_var *(character)* Name of the variable for the color aesthetic.
#' @param alpha_var *(numeric)* Transparency level of points (0 to 1).
#' @param size_var *(numeric)* Size of points.
#'
#' @return A `ggplot` object representing the scatter plot.
#'
#' @section Details:
#' `scatter_plot()` is designed for use in Shiny applications but can also be 
#'  used independently.
#' It supports customization of transparency, size, and color aesthetics.
#'
#' @seealso
#' - [`mod_scatter_display_server()`] for integrating this function into the
#'   scatter plot module.
#' - [`ggplot2::ggplot()`](https://ggplot2.tidyverse.org/) for details on 
#'   `ggplot2` usage.
#'
#' @family **Utility Functions**
#'
#' @examples
#' scatter_plot(
#'   df = mtcars,
#'   x_var = "mpg",
#'   y_var = "hp",
#'   col_var = "cyl",
#'   alpha_var = 0.7,
#'   size_var = 3
#' )
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
