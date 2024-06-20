#' Convert snake_case to Sentence Case
#'
#' `title_labs()` converts a given `snake_case` string to a `Sentence Case` string.
#'
#' @param x A character string in `snake_case`.
#' 
#' @return A character string converted to `Sentence Case`.
#' 
#' @details 
#' The `title_labs` function splits the input string by underscores, capitalizes 
#' the first letter of each word, and combines the words with spaces. 
#' This is particularly useful for converting variable names into more readable
#' labels for plots.
#' 
#' For example, when used with the `ggplot2::labs()` function, `title_labs` can
#' automatically convert `snake_case` labels into `Sentence Case` labels for 
#' better readability.
#' 
#' ```r
#' library(ggplot2)
#' 
#' # Example data
#' df <- data.frame(snake_case_var = rnorm(10))
#' 
#' # Example usage in ggplot2
#' ggplot(df, aes(x = snake_case_var)) +
#'   geom_histogram() +
#'   labs(x = title_labs("snake_case_var"))
#' ```
#' 
#' This will result in an x-axis label "Snake Case Var".
#' 
#' @examples
#' title_labs("snake_case_example")
#' title_labs("space example")
#' 
#' @export
#' 
#' 
title_labs <- function(x) {
  # split the string by underscores
  if (grepl("_", x)) {
    sep_words <- strsplit(x, "_")[[1]]
  } else {
    sep_words <- strsplit(x, "[^[:alnum:]]+")[[1]]
  }
  
  # sentence case each word
  first_letter_caps <- toupper(substring(sep_words, first = 1, last = 1))
  title_case_words <- paste0(first_letter_caps, 
                            substring(text = sep_words, first = 2))
  
  # combine the words with spaces
  title_case_string <- paste(title_case_words, collapse = " ")
  
  return(title_case_string)
}
