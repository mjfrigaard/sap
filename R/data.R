#' Movies dataset
#'
#' Information on 651 randomly sampled movies produced and released
#' before 2016. Compiled from Rotten Tomatoes and IMDB.
#'
#' @format A data frame with 651 rows and 34 variables:
#' \describe{
#'   \item{title}{Title of the movie.}
#'   \item{title_type}{Type of movie (Documentary, Feature Film, TV Movie).}
#'   \item{genre}{Genre of the movie.}
#'   \item{runtime}{Runtime in minutes.}
#'   \item{mpaa_rating}{MPAA rating (G, PG, PG-13, R, NC-17, Unrated).}
#'   \item{studio}{Studio that produced the movie.}
#'   \item{thtr_rel_date, thtr_rel_year, thtr_rel_month, thtr_rel_day}{Theatrical release date components.}
#'   \item{dvd_rel_date, dvd_rel_year, dvd_rel_month, dvd_rel_day}{DVD release date components.}
#'   \item{imdb_rating}{IMDB rating.}
#'   \item{imdb_num_votes}{Number of IMDB votes.}
#'   \item{critics_rating}{Rotten Tomatoes critics rating (Certified Fresh, Fresh, Rotten).}
#'   \item{critics_score}{Rotten Tomatoes critics score.}
#'   \item{audience_rating}{Rotten Tomatoes audience rating (Spilled, Upright).}
#'   \item{audience_score}{Rotten Tomatoes audience score.}
#'   \item{best_pic_nom, best_pic_win}{Oscar best picture nomination / win indicators.}
#'   \item{best_actor_win, best_actress_win, best_dir_win}{Oscar individual win indicators.}
#'   \item{top200_box}{Whether the movie is in the top 200 box office list on BoxOfficeMojo.}
#'   \item{director}{Director of the movie.}
#'   \item{actor1, actor2, actor3, actor4, actor5}{Top-billed actors.}
#'   \item{imdb_url, rt_url}{IMDB and Rotten Tomatoes URLs.}
#' }
#' @source Rotten Tomatoes and IMDB.
"movies"
