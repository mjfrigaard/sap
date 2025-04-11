#' Create Awards Wins Data Frame
#' 
#' Create data containing whether movies won or lost a specified award within the given year range.
#'
#' @param df movies data.frame
#' @param award character string 
#' @param start_year integer 
#' @param end_year integer 
#' 
#' @return A data frame 
#' 
#' @examples
#' create_movie_wins(movies, "Films", 2000, 2005)
#' create_movie_wins(movies, "Stars", 1990, 1994)
#' 
#' @export
#' 
create_movie_wins <- function(df, award, start_year, end_year) {

  df <- sap::movies

  # input checks
  if (start_year > end_year) {
    start_year <- start_year + 4
  }
  
  if ((end_year - start_year) > 10) {
    start_year <- start_year - 10
  }

  # extract award columns
  award_columns <- grep("^best", colnames(df), value = TRUE)
  
  # tidy up awards data
  tidy_awards <- do.call(rbind, lapply(award_columns, function(col) {
    data.frame(
      title = df$title,
      thtr_rel_date = df$thtr_rel_date,
      award = col,
      win = factor(df[[col]], levels = c("yes", "no"), labels = c("Yes", "No"))
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
  
  return(wins)

}