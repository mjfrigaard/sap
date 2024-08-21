#' Convert snake_case to Sentence Case
#'
#' `name_case()` converts a given `snake_case` string to a `Sentence Case` string.
#'
#' @param x A character string in `snake_case`.
#' 
#' @return A character string converted to `Sentence Case`.
#' 
#' @details 
#' The `name_case` function splits the input string by underscores, capitalizes 
#' the first letter of each word, and combines the words with spaces. 
#' This is particularly useful for converting variable names into more readable
#' labels for plots.
#' 
#' For example, when used with the `ggplot2::labs()` function, `name_case` can
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
#'   labs(x = name_case("snake_case_var"))
#' ```
#' 
#' This will result in an x-axis label "Snake Case Var".
#' 
#' @examples
#' name_case("snake_case_example")
#' name_case("space example")
#' name_case("Title Case Example", "lower")
#' name_case("Title Example", "lower")
#' 
#' @export
#' 
#' 
name_case <- function(x, case = "title") {
  # check if input is a character vector
  if (!is.character(x)) {
    stop("Input must be a character vector")
  }
  
  # change the case of a single name
  change_case <- function(name, case) {
    # split the string by underscores or other non-alphanumeric characters
    sep_words <- strsplit(name, "_|[^[:alnum:]]+")[[1]]
    
    # Change case of each word
    case_words <- switch(case,
                   title = paste0(
                              toupper(substring(sep_words, 1, 1)), 
                                      substring(sep_words, 2)),
                   lower = tolower(sep_words),
                   stop("Unsupported case"))
    
    # Combine the words
    return(paste(case_words, collapse = " "))
  }
  
  # apply change_case to all elements 
  named_vector <- sapply(x, change_case, case)
  
  return(unname(named_vector))
}
