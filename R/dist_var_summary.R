#' Summarize Numeric Variable by Group
#'
#' This function computes summary statistics (mean, standard 
#' deviation, min, max, IQR) for a numeric variable grouped by
#' a character variable.
#'
#' @param data (data.frame) containing at least one grouping 
#'  and one numerical variable.
#' @param grp_var (string) character variable to group by.
#' @param num_var (string) numeric variable to summarize.
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
dist_var_summary <- function(data, grp_var, num_var) {
  
  if (!is.data.frame(data)) {
    stop("The input 'data' must be a data frame.")
  }
  # check character strings
  if (!is.character(grp_var) || length(grp_var) != 1) {
    stop("The input 'grp_var' must be a single character string.")
  }
  if (!is.character(num_var) || length(num_var) != 1) {
    stop("The input 'num_var' must be a single character string.")
  }
  # check in the data frame
  if (!(grp_var %in% names(data))) {
    stop(paste("The character variable", grp_var, "does not exist in the data frame."))
  }
  if (!(num_var %in% names(data))) {
    stop(paste("The numeric variable", num_var, "does not exist in the data frame."))
  }
  # check if character or factor
  if (!is.character(data[[grp_var]]) && !is.factor(data[[grp_var]])) {
    stop(paste("The variable", grp_var, "must be of type character or factor."))
  }
  # check if numeric
  if (!is.numeric(data[[num_var]])) {
    stop(paste("The variable", num_var, "must be of type numeric."))
  }
  unique_groups <- unique(data[[grp_var]])
  result <- do.call(rbind, lapply(unique_groups, function(group) {
    subset_data <- data[data[[grp_var]] == group, ]
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
