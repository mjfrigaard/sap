#' Get column names from movies
#'
#' @param var variable from UI
#'
#' @returns character vector of column name from `movies` data
#' 
#' @export
#'
get_column_name <- function(var) {
  if (is.null(var)) return(NULL)
  
  if (is.symbol(var)) {
    var_name <- as.character(var)
  } else if (is.character(var)) {
    var_name <- var
  } else {
    return(NULL)
  }
  
  # lowercase snake_case
  col_name <- tolower(gsub(" ", "_", var_name))
  # check if it exists 
  all_cols <- tolower(names(movies))
  if (col_name %in% all_cols) {
    # return to original case 
    idx <- which(all_cols == col_name)
    return(names(movies)[idx])
  }
  return(NULL)
}