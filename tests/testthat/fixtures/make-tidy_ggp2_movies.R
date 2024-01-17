# tidy_movies
make_tidy_ggp2_movies <- function(movies_data_url) {
  movies_data <- read.csv(file = movies_data_url)
  # specify genre columns
  genre_cols <- c(
    "Action", "Animation",
    "Comedy", "Drama",
    "Documentary", "Romance",
    "Short"
  )
  # calculate row sum for genres
  movies_data$genre_count <- rowSums(movies_data[, genre_cols])
  # create aggregate 'genres' for multiple categories
  movies_data$genres <- apply(
    X = movies_data[, genre_cols],
    MARGIN = 1,
    FUN = function(row) {
      genres <- names(row[row == 1])
      if (length(genres) > 0) {
        return(paste(genres, collapse = ", "))
      } else {
        return(NA)
      }
    }
  )
  # format variables
  movies_data$genre_count <- as.integer(movies_data$genre_count)
  movies_data$genre <- ifelse(test = movies_data$genre_count > 1,
    yes = "Multiple genres",
    no = movies_data$genres
  )
  movies_data$genre <- as.factor(movies_data$genre)
  movies_data$mpaa <- factor(movies_data$mpaa,
    levels = c("G", "PG", "PG-13", "R", "NC-17"),
    labels = c("G", "PG", "PG-13", "R", "NC-17")
  )

  # reduce columns to only those in graph
  movies_data[, c(
    "title", "year", "length", "budget",
    "rating", "votes", "mpaa", "genre_count",
    "genres", "genre"
  )]
}

tidy_ggp2_movies <- make_tidy_ggp2_movies("https://raw.githubusercontent.com/hadley/ggplot2movies/master/data-raw/movies.csv")

# save to tests/testthat/fixtures/
saveRDS(object = tidy_ggp2_movies, 
  file = "tests/testthat/fixtures/tidy_ggp2_movies.rds")