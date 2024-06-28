#' Create a Data Frame of Movie Awards
#'
#' This function processes a movie data frame to create a tidy data frame of 
#' movie awards.
#'
#' @param movies A data frame containing movie data, including award columns 
#' that start with "best".
#'
#' @return A data frame with columns `title`, `award`, `win`, and `thtr_rel_date`.
#'
#' @details
#' The `create_movie_awards` function reshapes the input movie data frame to 
#' extract information about various awards. It identifies columns that start 
#' with "best", indicating different awards such as best picture, best actor, 
#' etc. The function pivots these columns into a long format, creating a new
#' data frame where each row represents a movie and an associated award. The 
#' award column names are cleaned up for readability by replacing abbreviations
#' with full words, and the `win` column values are standardized to "Yes" and 
#' "No". The resulting data frame includes the movie title, theater release 
#' date, award type, and whether the award was won.
#'
#' @export
#' 
#' @examples
#' str(create_movie_awards(movies))
#' 
create_movie_awards <- function(movies) {
  award_columns <- grep("^best", colnames(movies), value = TRUE)
  tidy_awards <- do.call(rbind, lapply(award_columns, function(col) {
    data.frame(
      title = movies$title,
      thtr_rel_date = movies$thtr_rel_date,
      award = col,
      win = movies[[col]]
    )
  }))
  # clean up the 'award' column
  tidy_awards$award <- gsub("_", " ", tidy_awards$award)
  tidy_awards$award <- gsub("best", "Best", tidy_awards$award)
  tidy_awards$award <- gsub("pic", "Picture", tidy_awards$award)
  tidy_awards$award <- gsub("nom", "Nomination", tidy_awards$award)
  tidy_awards$award <- gsub("dir", "Director", tidy_awards$award)
  # clean up the 'win' column
  tidy_awards$win <- gsub("no", "No", tidy_awards$win)
  tidy_awards$win <- gsub("yes", "Yes", tidy_awards$win)
  # relevant columns
  movie_awards <- tidy_awards[ , c("title", "award", "win", "thtr_rel_date")]
  movie_awards <- movie_awards[order(movie_awards$thtr_rel_date),]
  return(movie_awards)
}


# make_movie_awards <- function() {
#   
#   tidy_awards <- tidyr::pivot_longer(movies,
#       cols = starts_with('best'),
#       names_to = "award",
#       values_to = "win")
# 
#   clean_awards <- dplyr::mutate(tidy_awards,
#       win = stringr::str_to_title(win),
#       win = factor(win),
#       award = stringr::str_replace_all(award, "_", " "),
#       award = stringr::str_replace_all(award, "pic", "picture"),
#       award = stringr::str_replace_all(award, "nom", "nomination"),
#       award = stringr::str_replace_all(award, "dir", "director"),
#       award = stringr::str_to_title(award))
# 
#   movie_awards <- dplyr::select(clean_awards, title, award, win, thtr_rel_date)
# 
#   arrange(movie_awards, thtr_rel_date)
# 
# }
