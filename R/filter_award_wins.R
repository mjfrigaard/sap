#' Filter award wins data (support function)
#'
#' This function the award wins data into a dataset of **only** wins.
#'
#' @param award_data wins data to filter 
#' @param award character string ("Film" or "Stars")
#' @param start_year integer (start theater release year)
#' @param end_year integer (end theater release year)
#' 
#' @return A data frame containing movies that won the specified award within 
#'   the given year range.
#' 
#' @seealso [create_award_wins()] [create_movie_awards()] 
#' 
#' 
#' @export
#' 
filter_award_wins <- function(award_data, award, start_yr, end_yr) {
  yr_range <- subset(award_data, year >= start_yr & year <= end_yr)
  awards <- switch(award, 
                    Films = subset(yr_range, award %in% c("Best Picture", "Best Director")),
                    Stars = subset(yr_range, award %in% c("Best Actor", "Best Actress")),
                    stop("Invalid award type. Use 'Films' for Best Picture/Director or 'Stars' for Best Actor/Actress.")
  )
  return(awards)
}