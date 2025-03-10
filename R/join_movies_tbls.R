#' Join and Filter Movie Tables
#'
#' This function joins the `omdb` and `tomatoes` tables from an SQLite database
#' connection, filters out movies with fewer than 5 reviews, and selects
#' relevant columns.
#'
#' @param con A `DBIConnection` object representing the connection to the SQLite
#' database.
#' @param collect A logical value indicating whether to retrieve the results
#' into a local `data.frame`. If `FALSE` (default), returns a lazy `tbl` for
#' efficient database queries.
#'
#' @return A `tbl` object if `collect = FALSE`, or a `data.frame`
#' if `collect = TRUE`.
#'
#' @export
#' 
join_movies_tbls <- function(con, collect = FALSE) {

  # create connection to both data tables
  omdb <- dplyr::tbl(con, "omdb")
  tomatoes <- dplyr::tbl(con, "tomatoes")

  # join tables, filtering out those with <5 reviews, and select specified columns
  all_movies <- dplyr::inner_join(x = omdb, y = tomatoes,
                                  by = "ID") |>
  dplyr::filter(Reviews >= 5) |>
  dplyr::select(id = ID,
    imdb_id = imdbID,
    title = Title,
    year = Year,
    omdb_ratings = Rating.x,
    rt_ratings = Rating.y,
    omdb_last_updated = lastUpdated.x,
    rt_last_updated = lastUpdated.y,
    runtime = Runtime,
    genre = Genre,
    released = Released,
    director = Director,
    writer = Writer,
    imdb_rating = imdbRating,
    imdb_votes = imdbVotes,
    language = Language,
    country = Country,
    oscars = Oscars,
    meter = Meter,
    reviews = Reviews,
    fresh = Fresh,
    rotten = Rotten,
    user_meter = userMeter,
    user_rating = userRating,
    user_reviews = userReviews,
    box_office = BoxOffice,
    production = Production,
    cast = Cast
  )
  if (collect) {
    return(
      dplyr::collect(all_movies)
    )
  } else {
    return(
      all_movies
    )
  }

}
