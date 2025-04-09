# contents of app/logic/data.R

#' @export
box::use(
  vroom[vroom, cols, col_skip]
)

#' import movies data 
#' @export
movies_data <- function() {
  raw_csv_url <- "https://tinyurl.com/5cdmpuzy"
  vroom(
    file = raw_csv_url, 
    delim = ",", 
    col_names = TRUE,
    show_col_types = FALSE)
}