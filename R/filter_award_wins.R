#' Filter Movie Awards (support function)
#'
#' This function filters movie awards data.
#'
#' @param award_data data to filter 
#' @param award character string 
#' @param start_year integer 
#' @param end_year integer 
#' 
#' @return A data frame containing movies that won the specified award within 
#'   the given year range.
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