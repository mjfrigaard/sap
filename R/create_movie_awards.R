#' Create a Filtered Movie Awards Data Frame
#'
#' This function filters movie awards data based on a specified award type and a given year range.
#' It checks that `start_year` is less than `end_year` and that the range is no greater than 5 years.
#'
#' @param award A character string specifying the type of award to filter. Can be "pic" for Best Picture/Director or "act" for Best Actor/Actress.
#' @param start_year An integer specifying the starting year of the filter range.
#' @param end_year An integer specifying the ending year of the filter range.
#' 
#' @return A data frame containing movies that won the specified award within the given year range.
#' @examples
#' create_movie_awards("pic", 2000, 2005)
#' create_movie_awards("act", 1990, 1994)
#' @export
create_movie_awards <- function(award, start_year, end_year) {
  
  # input checks
  if (start_year > end_year) {
    start_year <- start_year + 4
  }
  
  if ((end_year - start_year) > 10) {
    start_year <- start_year - 10
  }

  # extract award columns
  award_columns <- grep("^best", colnames(movies), value = TRUE)
  
  # tidy up awards data
  tidy_awards <- do.call(rbind, lapply(award_columns, function(col) {
    data.frame(
      title = movies$title,
      thtr_rel_date = movies$thtr_rel_date,
      award = col,
      win = factor(movies[[col]], levels = c("yes", "no"), labels = c("Yes", "No"))
    )
  }))
  
  # clean up the 'award' column
  tidy_awards$award <- gsub("_", " ", tidy_awards$award)
  tidy_awards$award <- gsub("best", "Best", tidy_awards$award)
  tidy_awards$award <- gsub("pic", "Picture", tidy_awards$award)
  tidy_awards$award <- gsub("nom", "Nomination", tidy_awards$award)
  tidy_awards$award <- gsub("dir", "Director", tidy_awards$award)
  tidy_awards$award <- gsub("actor", "Actor", tidy_awards$award)
  tidy_awards$award <- gsub("actress", "Actress", tidy_awards$award)
  tidy_awards$award <- gsub(" win$", "", tidy_awards$award)
  
  # create a 'year' column
  tidy_awards$year <- as.numeric(format(tidy_awards$thtr_rel_date, "%Y"))
  
  # select relevant columns
  award_cols <- tidy_awards[, c("title", "award", "year", "win")]
  
  # filter out award nominations
  wins <- subset(award_cols, win == "Yes", select = c("title", "award", "year"))
  
  # define filter function
  filter_awards <- function(award_data, award, start_yr, end_yr) {
    yr_range <- subset(award_data, year >= start_yr & year <= end_yr)
    awards <- switch(award, 
                     Films = subset(yr_range, award %in% c("Best Picture", "Best Director")),
                     Stars = subset(yr_range, award %in% c("Best Actor", "Best Actress")),
                     stop("Invalid award type. Use 'Films' for Best Picture/Director or 'Stars' for Best Actor/Actress.")
    )
    return(awards)
  }
  
  # apply filter function
  movie_awards <- filter_awards(award_data = wins, award = award, 
                                start_yr = start_year, end_yr = end_year)
  return(movie_awards)
}
