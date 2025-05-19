#' Extract variable names safely
#' 
#' Convert any language/expression to character and extract just the variable name
#'
#' @param var_expr variable expression
#'
#' @returns cleaned variable name
#' 
#' @export
#'
extract_var_name <- function(var_expr) {
  var_str <- as.character(var_expr)
  # both quoted and non-quoted variable references
  if (length(var_str) > 1 && var_str[1] == "$") {
    return(var_str[3])  # for something like `$`(movies, "variable_name")
  } else {
    # remove any prefix, dollar signs, etc.
    clean_name <- gsub(".*\\$|[\"']", "", var_str)
    return(clean_name)
  }
}