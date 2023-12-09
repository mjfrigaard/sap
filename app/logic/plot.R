# contents of app/logic/plot.R

#' scatter plot function
#' @export
scatter_plot <- function(df, x_var, y_var, col_var, alpha_var, size_var) {

box::use(
  ggplot2[ggplot, aes, geom_point],
  rlang[.data]
)
  
  ggplot(
    data = df,
    aes(
      x = .data[[x_var]],
      y = .data[[y_var]],
      color = .data[[col_var]]
    )
  ) +
    geom_point(alpha = alpha_var, size = size_var)
  
}
