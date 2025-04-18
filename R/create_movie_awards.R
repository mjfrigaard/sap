#' Create Movie Awards Data Frame
#' 
#' Combines `create_award_wins()` and `filter_award_wins()`.
#'
#' @param df movies data.frame
#' @param award character string ("Film" or "Stars")
#' @param start_year integer (start theater release year)
#' @param end_year integer (end theater release year)
#' 
#' @return A data frame 
#' 
#' @seealso [filter_award_wins()] [create_movie_awards()]
#' 
#' @examples
#' create_movie_awards(movies, "Films", 2000, 2005)
#' create_movie_awards(movies, "Stars", 1990, 1994)
#' 
#' @export
#' 
create_movie_awards <- function(df, award, start_year, end_year) {

  df <- sap::movies

  movie_awards <- create_movie_wins(movies, award, start_year, end_year) |> 

    filter_award_wins(award, start_year, end_year)

  return(movie_awards)

}
