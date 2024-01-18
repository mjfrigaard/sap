# app/logic/data.R

#' @export
box::use(
  vroom[vroom]
)


#' import movies data
#' @export
movies_data <- function() {
  raw_csv_url <- "https://bit.ly/47FPO6t"
  # from 07_data branch!
  vroom(raw_csv_url)
}
