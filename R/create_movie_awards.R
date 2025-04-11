#' Create a Filtered Movie Awards Data Frame
#'
#' This function filters movie awards data based on a specified award type and a given year range.
#' It checks that `start_year` is less than `end_year` and that the range is no greater than 5 years.
#'
#' @param df movies data.frame
#' @param award A character string specifying the type of award to filter. Can be "pic" for Best Picture/Director or "act" for Best Actor/Actress.
#' @param start_year An integer specifying the starting year of the filter range.
#' @param end_year An integer specifying the ending year of the filter range.
#' 
#' @return A data frame containing movies that won the specified award within the given year range.
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
