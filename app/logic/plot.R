# contents of app/logic/plot.R

#' point plot function
#' @export
point_plot <- function(df, x_var, y_var, col_var, alpha_var, size_var) {

box::use(
  ggplot2 = ggplot2[...]
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
