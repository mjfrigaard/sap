#' Create a Movie Awards Data Frame
#' 
#' Movie awards (Film or Actor).
#'
#' @param df movies data.frame
#' @param award character string 
#' @param start_year integer 
#' @param end_year integer 
#' 
#' @return A data frame 
#' 
#' @examples
#' create_movie_awards(movies, "Films", 2000, 2005)
#' create_movie_awards(movies, "Stars", 1990, 1994)
#' @export
create_movie_awards <- function(df, award, start_year, end_year) {

  df <- sap::movies

  movie_awards <- create_movie_wins(movies, award, start_year, end_year) |> 

    filter_award_wins(award, start_year, end_year)

  return(movie_awards)

}
