#' Plot points (shiny)
#'
#' @param df input dataset (tibble or data.frame)
#' @param x_var x variable
#' @param y_var y variable
#' @param col_var color variable
#' @param alpha_var alpha value
#' @param size_var size value
#'
#' @return plot object
#' @export scatter_plot
#'
#' @importFrom rlang .data
#'
#' @examples
#' \donttest{
#' load(
#'   list.files(
#'     system.file("extdata", package = "lap"),
#'    pattern = "movies",
#'    full.names = TRUE)
#'    )
#' scatter_plot(df = movies,
#'   x_var = "critics_score",
#'   y_var = "imdb_rating",
#'   col_var = "critics_rating",
#'   alpha_var = 1/3,
#'   size_var = 2)
#' }
scatter_plot <- function(df, x_var, y_var, col_var, alpha_var, size_var) {
    ggplot2::ggplot(data = df,
      ggplot2::aes(x = .data[[x_var]],
          y = .data[[y_var]],
          color = .data[[col_var]])) +
      ggplot2::geom_point(alpha = alpha_var, size = size_var)

}
