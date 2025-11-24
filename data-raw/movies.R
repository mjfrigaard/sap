movies <- vroom::vroom(file = "inst/extdata/movies.csv")
movies <- movies |>
  dplyr::mutate(
    genre = as.factor(genre),
    mpaa_rating = as.factor(mpaa_rating),
    critics_rating = as.factor(critics_rating)
  )
usethis::use_data(movies, overwrite = TRUE)