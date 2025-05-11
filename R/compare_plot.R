#' Create comparison chart (report)
#'
#' @param data movies dataset
#' @param x x variable from UI
#' @param y y variable from UI
#' @param color color variable from UI
#' @param alpha alpha aesthetic from UI
#' @param size size aesthetic from UI
#' @param title title text from UI
#'
#' @returns ggplot2 object
#' 
#' @export
#'
compare_plot <- function(data, x, y, color = NULL, alpha = 0.7, size = 3, title = NULL) {
  # create base plot with x and y only
  p <- ggplot2::ggplot(data = data, 
              mapping = ggplot2::aes(x = .data[[x]], y = .data[[y]]))
  
  # points - handle color separately
  if (!is.null(color)) {
    p <- p + ggplot2::geom_point(ggplot2::aes(color = .data[[color]]), alpha = alpha, size = size)
    p <- p + ggplot2::scale_color_brewer(palette = "Set2")
  } else {
    p <- p + ggplot2::geom_point(alpha = alpha, size = size)
  }
  
  # add labels
  p <- p + ggplot2::labs(
    x = name_case(x),
    y = name_case(y)
  )
  
  # add title if provided
  if (!is.null(title) && nchar(title) > 0) {
    p <- p + ggplot2::labs(title = title)
  }
  
  # add color label if provided
  if (!is.null(color)) {
    p <- p + ggplot2::labs(color = name_case(color))
  }
  
  return(p)
}