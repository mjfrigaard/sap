pkgs <- c("ggplot2movies", "tidyr", "dplyr", "stringr", "purrr")
install.packages(pkgs, quiet = TRUE)
library(tidyr)
library(dplyr)
library(stringr)
library(purrr)

tidy_ggp2_movies <- ggplot2movies::movies |>
  tibble::add_column(row_id = 1:nrow(ggplot2movies::movies)) |>
  tidyr::pivot_longer(c(Action:Short),
    names_to = "genre_key",
    values_to = "genre_value"
  ) |>
  dplyr::mutate(genre_value = as.logical(genre_value)) |>
  dplyr::group_by(row_id) |>
  dplyr::mutate(
    genres = paste0(genre_key, collapse = ", ")
  ) |>
  dplyr::ungroup() |>
  dplyr::distinct(title, .keep_all = TRUE) |>
  dplyr::mutate(
    genres = dplyr::na_if(x = genres, ""),
    genres = factor(genres),
    mpaa = dplyr::na_if(x = mpaa, y = ""),
    mpaa = factor(mpaa,
      levels = c("G", "PG", "PG-13", "R", "NC-17"),
      labels = c("G", "PG", "PG-13", "R", "NC-17")
    )
  ) |>
  dplyr::select(
    title, genres, length, year,
    budget, rating, votes, mpaa
  )
# save to tests/testthat/fixtures/
saveRDS(object = tidy_ggp2_movies, file = "tests/testthat/fixtures/tidy_ggp2_movies.rds")

# dist_titles <- unique(ggplot2movies::movies$title)
# dist_tidy_titles <- unique(tidy_ggp2_movies$title)
# waldo::compare(dist_titles, dist_tidy_titles)
# identical(dist_titles, dist_tidy_titles)
