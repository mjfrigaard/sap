# library(covtracer)

# additional demo packages
# library(dplyr)
# library(withr)
# library(covr)

withr::with_options(new = list(covr.record_tests = TRUE), code = {
  cov <- covr::package_coverage()
  ttdf <- test_trace_df(cov)
})


tidy_ggp2_movies2 <- function(movies_data_url) {
  movies_data <- vroom::vroom(file = movies_data_url)
  # restructure
  long_data <- movies_data |>
    dplyr::rowwise() |>
    dplyr::mutate(genre_count = sum(c(
      Action, Animation, Comedy,
      Drama, Documentary,
      Romance, Short
    ))) |>
    tidyr::pivot_longer(
      cols = c(Action:Short),
      names_to = "genre_name",
      values_to = "genre_indicator"
    )
  # aggregate data
  aggregated_data <- long_data |>
    dplyr::filter(genre_indicator > 0) |>
    dplyr::group_by(title, year) |>
    dplyr:::summarise(
      genres = paste0(genre_name, collapse = ", "),
      .groups = "drop"
    )
  # join data
  joined_data <- dplyr::left_join(
    x = long_data,
    y = aggregated_data,
    by = intersect(
      x = names(long_data),
      y = names(aggregated_data)
    )
  ) |>
    dplyr::select(
      title, year, length,
      budget, rating, votes, mpaa,
      genre_count, genres
    ) |>
    dplyr::distinct()

  dplyr::mutate(joined_data,
    genre = dplyr::case_when(
      genre_count > 1 ~ "Multiple genres",
      genre_count == 1 ~ genres,
      TRUE ~ genres
    ),
    genre = factor(genre),
    genre_count = as.integer(genre_count),
    mpaa = dplyr::na_if(x = mpaa, y = ""),
    mpaa = factor(mpaa,
      levels = c("G", "PG", "PG-13", "R", "NC-17"),
      labels = c("G", "PG", "PG-13", "R", "NC-17")
    )
  ) |> 
    # convert to df
    as.data.frame()
}

# base version 
# bdat <- tidy_ggp2_movies("https://raw.githubusercontent.com/hadley/ggplot2movies/master/data-raw/movies.csv")

# dplyr & tidyr version
# tdat <- tidy_ggp2_movies2("https://raw.githubusercontent.com/hadley/ggplot2movies/master/data-raw/movies.csv")

# # get subset of multiple genres 
# bdat_genres <- dplyr::filter(bdat, genre_count > 2) |>
#   dplyr::select(title, genre_count, genre, genres)
# tdat_genres <- dplyr::filter(tdat, genre_count > 2) |>
#   dplyr::select(title, genre_count, genre, genres)
# # compare
# waldo::compare(bdat_genres, tdat_genres)
