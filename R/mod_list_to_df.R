#' Convert a Named List into a Data Frame
#'
#' This function takes a named list, where names follow the format
#'  `"namespace-id"`, and converts it into a structured data frame with columns
#'  for namespace, id, values, and their respective data types.
#'
#' @param lst A named list where names are in the format `"namespace-id"`, and
#' values  can be character, integer, or numeric vectors.
#'
#' @return A `data.frame` with three columns:
#' The first half of the data frame contains actual values, while the second half contains data types.
#' *  `ns` - The namespace extracted from the name (e.g., `"selects"`, `"sliders"`, `"text"`).
#' *  `id` - The identifier extracted from the name (e.g., `"genre"`, `"xvar"`, `"reviews"`).
#' *  `value` - The associated value(s) as a character string, or the corresponding data type (`"chr"`, `"int"`, `"num"`).
#' 
#'
#' @export
#'
mod_list_to_df <- function(lst){
  # Remove any list items where the name contains "__reactable__"
  lst <- lst[!grepl("__reactable__", names(lst))]

  # Extract the namespace (prefix) and ID
  split_names <- strsplit(names(lst), "-")
  ns <- sapply(split_names, `[`, 1)
  id <- sapply(split_names, `[`, 2)

  # Extract values
  values <- sapply(lst, function(x){
    if (length(x) > 1) {
      paste(x, collapse = ", ")
    } else {
      as.character(x)
    }
  })

  # Extract data types as class names
  class_types <- sapply(lst, function(x){
    if (is.character(x)) {
      "chr"
    } else if (is.integer(x)) {
      "int"
    } else if (is.numeric(x)) {
      "num"
    } else {
      "other"
    }
  })

  # Create the data frame with ns, id, value, and class columns
  df <- data.frame(
    ns = ns,
    id = id,
    value = values,
    class = class_types,
    stringsAsFactors = FALSE
  )

  # Reset row names
  rownames(df) <- NULL

  return(df)
}




