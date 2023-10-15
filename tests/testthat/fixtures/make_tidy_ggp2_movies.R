# pkgs <- c('ggplot2movies', 'tidyr', 'dplyr', 'stringr', 'purrr')
# install.packages(pkgs, quiet = TRUE)

library(tidyr)
library(dplyr)
library(stringr)
library(purrr)

tidy_ggp2_movies <- tidy_movies <- ggplot2movies::movies |>
  tidyr::pivot_longer(c(Action:Short),
    names_to = "genre_key",
    values_to = "genre_value"
  ) |>
  dplyr::mutate(genre_value = as.logical(genre_value)) |>
  dplyr::filter(genre_value == TRUE) |>
  dplyr::group_by(title) |>
  dplyr:::mutate(
    genres = paste0(genre_key, collapse = ", ")
  ) |>
  dplyr::ungroup() |>
  dplyr::distinct(.keep_all = TRUE) |>
  dplyr::mutate(
    genres = dplyr::na_if(x = genres, ""),
    genre = dplyr::case_when(
                stringr::str_detect(genres, ",") ~ 'Multiple genres',
                TRUE ~ genres),
    genre = factor(genre),
    mpaa = dplyr::na_if(x = mpaa, y = ""),
    mpaa = factor(mpaa,
      levels = c("G", "PG", "PG-13", "R", "NC-17"),
      labels = c("G", "PG", "PG-13", "R", "NC-17"))
    ) |>
  dplyr::select(
    title, -genre, length, year,
    budget, rating, votes, mpaa
  )
# save to tests/testthat/fixtures/
saveRDS(object = tidy_ggp2_movies, 
  file = "tests/testthat/fixtures/tidy_ggp2_movies.rds")

dist_titles <- unique(ggplot2movies::movies$title)
dist_tidy_titles <- unique(tidy_ggp2_movies$title)
waldo::compare(dist_titles, dist_tidy_titles)
identical(dist_titles, dist_tidy_titles)
