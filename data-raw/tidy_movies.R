## code to prepare `ggp2movies` dataset goes here
# pkgs <- c('ggplot2movies', 'tidyr', 'dplyr', 'stringr', 'fst')
# install.packages(pkgs, quiet = TRUE)

# load packages --------------------
library(tidyr)
library(dplyr)
library(stringr)
library(fst)

# tidy_movies
tidy_movies <- ggplot2movies::movies |>
  tidyr::pivot_longer(c(Action:Short),
    names_to = "genre_key",
    values_to = "genre_value"
  ) |>
  dplyr::mutate(genre_value = as.logical(genre_value)) |>
  dplyr::select(
    title, genre_key, genre_value, length,
    year, budget, rating, votes, mpaa
  ) |>
  dplyr::filter(genre_value == TRUE) |>
  dplyr::group_by(title) |>
  dplyr:::mutate(
    genres = paste0(genre_key, collapse = ", ")
  ) |>
  dplyr::select(
    title, genres, length, year,
    budget, rating, votes, mpaa
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
  dplyr::select(-genres)
# save to inst/dev/
fst::write_fst(x = tidy_movies, path = "inst/dev/tidy_movies.fst")
