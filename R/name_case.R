#' Change the case of text
#'
#' @param x A character vector.
#' @param case One of `"title"` or `"lower"`. Optional.
#'
#' @returns
#' A character vector with the case changed according to the specified 
#' format. Will error if input is not a character vector or if an 
#' unsupported case is specified.
#' 
#' @examples 
#' name_case(c("user.name", "full-name", "Some Value"), case = "lower")
#' name_case(c("user.name", "full-name", "Some Value"), case = "title")
#'
#' @export
#' 
name_case <- function(x, case = "title") {
  if (!is.character(x)) {
    stop("Input must be a character vector.")
  }

  change_case <- function(name, case) {
    # Split by underscores or non-alphanumeric characters
    sep_words <- strsplit(name, "_|[^[:alnum:]]+")[[1]]

    case_words <- switch(
      case,
      title = paste0(
        toupper(substring(sep_words, 1, 1)),
        tolower(substring(sep_words, 2))
      ),
      lower = tolower(sep_words),
      stop("Unsupported case.")
    )

    if (case == "lower") {
      # Return snake_case
      return(paste(case_words, collapse = "_"))
    } else {
      # Return title case with spaces
      return(paste(case_words, collapse = " "))
    }
  }

  named_vector <- sapply(x, change_case, case)

  return(unname(named_vector))
}
