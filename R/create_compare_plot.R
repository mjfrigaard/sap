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
create_compare_plot <- function(data, x, y, color = NULL, alpha = 0.7, size = 3, title = NULL) {
  # Create base plot with x and y only
  p <- ggplot(data = data, mapping = aes(x = .data[[x]], y = .data[[y]]))
  
  # Add points - handle color separately
  if (!is.null(color)) {
    p <- p + geom_point(aes(color = .data[[color]]), alpha = alpha, size = size)
    p <- p + scale_color_brewer(palette = "Set2")
  } else {
    p <- p + geom_point(alpha = alpha, size = size)
  }
  
  # Add labels
  p <- p + labs(
    x = name_case(x),
    y = name_case(y)
  )
  
  # Add title if provided
  if (!is.null(title) && nchar(title) > 0) {
    p <- p + labs(title = title)
  }
  
  # Add color label if provided
  if (!is.null(color)) {
    p <- p + labs(color = name_case(color))
  }
  
  return(p)
}