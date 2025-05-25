#' Create a Horizontal Bar Plot of Movies Count
#'
#' This function generates a horizontal bar plot showing the frequency counts of a 
#' selected categorical variable from the movies dataset, filtered by year range.
#'
#' @param data A dataframe containing the filtered movies data
#' @param chr_var The categorical variable to count (as a symbol)
#' @param x_label Label for the x-axis (title of the categorical variable)
#'
#' @return A ggplot2 object displaying a horizontal bar plot
#'
#' @details The function creates a bar chart with the categorical variable on the y-axis
#' (flipped coordinates) and the count on the x-axis. Categories are ordered by frequency
#' (most frequent at the top).
#' 
#' @examples
#' # create plot
#' count_bar_plot(data = movies, chr_var = "mpaa_rating", x_label = "mpaa_rating")
#'
#' @export
#' 
count_bar_plot <- function(data, chr_var, x_label) {
  plot <- ggplot2::ggplot(data = data, 
    ggplot2::aes(x = forcats::fct_rev(forcats::fct_infreq(.data[[chr_var]])))
  ) +
    ggplot2::geom_bar(
      ggplot2::aes(fill = .data[[chr_var]]),
      show.legend = FALSE
    ) +
    ggplot2::coord_flip() +
    ggplot2::scale_fill_manual(values = clr_pal12) +
    ggplot2::labs(
      y = "# of Movies",
      fill = unique(x_label)
    ) +
    ggplot2::theme(
      legend.position = "none",
      axis.text = ggplot2::element_text(color = "#ffffff", size = 14),
      axis.title = ggplot2::element_text(color = "#ffffff", size = 16)
    )
  print(plot)
}