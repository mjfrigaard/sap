get_all_movies <- function(db) {
  # Join tables, filter out those with <10 reviews, and select columns
  omdb <- dplyr::tbl(db, "omdb")
  tomatoes <- dplyr::tbl(db, "tomatoes")
  
  all_movies <- dplyr::inner_join(
    x = omdb,
    y = tomatoes,
    by = "ID"
  ) |>
    dplyr::filter(Reviews >= 10) |>
    dplyr::select(
      ID, imdbID, Title, Year, Rating_m = Rating.x, Runtime, Genre,
      Released, Director, Writer, imdbRating, imdbVotes, Language,
      Country, Oscars, Rating = Rating.y, Meter, Reviews,
      Fresh, Rotten, userMeter, userRating, userReviews, BoxOffice,
      Production, Cast
    )
  
  all_movies
}