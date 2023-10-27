# app/logic/data.R

#' @export
box::use(
  readr[get_csv = read_csv, cols]
)

#' import movies data from GitHub
#' @export
movies_data <- function() {
  raw_csv_url <- "https://bit.ly/3Jds4g1"
  # use alias for read_csv()
  get_csv(raw_csv_url, col_types = cols())
}
