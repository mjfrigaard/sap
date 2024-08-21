#' Summarize Numeric Variable by Group
#'
#' This function computes summary statistics (mean, standard deviation, min,
#' max, IQR) for a numeric variable grouped by a character variable.
#'
#' @param data A data frame containing the variables.
#' @param chr_var A string representing the name of the character variable
#' to group by.
#' @param num_var A string representing the name of the numeric variable
#' to summarize.
#'
#' @return A data frame with the summary statistics for each group.
#'
#' @examples
#' # Example usage:
#' df <- data.frame(group = c("A", "B", "A", "B"), value = c(10, 20, 30, 40))
#' dist_var_summary(df, "group", "value")
#' dist_var_summary(iris, 'Species', 'Sepal.Length')
#'
#' @export
#'
dist_var_summary <- function(data, chr_var, num_var) {
  # check if data is a data frame
  if (!is.data.frame(data)) {
    stop("The input 'data' must be a data frame.")
  }
  # check if chr_var and num_var are character strings
  if (!is.character(chr_var) || length(chr_var) != 1) {
    stop("The input 'chr_var' must be a single character string.")
  }
  if (!is.character(num_var) || length(num_var) != 1) {
    stop("The input 'num_var' must be a single character string.")
  }
  # check if chr_var and num_var exist in the data frame
  if (!(chr_var %in% names(data))) {
    stop(paste("The character variable", chr_var, "does not exist in the data frame."))
  }
  if (!(num_var %in% names(data))) {
    stop(paste("The numeric variable", num_var, "does not exist in the data frame."))
  }
  # check if chr_var is a character or factor variable
  if (!is.character(data[[chr_var]]) && !is.factor(data[[chr_var]])) {
    stop(paste("The variable", chr_var, "must be of type character or factor."))
  }
  # check if num_var is a numeric variable
  if (!is.numeric(data[[num_var]])) {
    stop(paste("The variable", num_var, "must be of type numeric."))
  }
  unique_groups <- unique(data[[chr_var]])
  result <- do.call(rbind, lapply(unique_groups, function(group) {
    subset_data <- data[data[[chr_var]] == group, ]
    n <- nrow(subset_data)
    Mean <- round(mean(subset_data[[num_var]], na.rm = TRUE), 2)
    SD <- round(sd(subset_data[[num_var]], na.rm = TRUE), 2)
    Min <- min(subset_data[[num_var]], na.rm = TRUE)
    Max <- max(subset_data[[num_var]], na.rm = TRUE)
    IQR_value <- round(IQR(subset_data[[num_var]], na.rm = TRUE), 2)
    data.frame(group = group, 
      n = n, Mean = Mean, SD = SD, 
      Min = Min, Max = Max, 
      IQR = IQR_value)
  }))
  rownames(result) <- NULL
  tbl_names <- name_case(names(result))
  tbl <- stats::setNames(object = result, nm = tbl_names)
  return(tbl)
}
