#' Convert symbols to character
#'
#' @param params 
#'
#' @returns list of params with character values
#' 
#' @export
#'
desym <- function(params) {
  recurse_lists <- function(x) {
    if (is.list(x)) {
      # Process each element in the list
      result <- lapply(x, recurse_lists)
      return(result)
    } else if (is.symbol(x)) {
      # Convert symbol to character
      return(as.character(x))
    } else {
      # Return other types unchanged
      return(x)
    }
  }
  recurse_lists(params)
}