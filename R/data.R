#' Movies dataset
#'
#' A dataset containing movie rankings from IMDB and Rotten Tomatoes. Original
#' source found [here](https://rstudio-education.github.io/shiny-course/)
#'
#' @format A data frame with 651 rows and 34 variables:
#'
#' \describe{
#'   \item{title}{movie title}
#'   \item{title_type}{title type (Documentary, Feature Film, TV, Movie)}
#'   \item{genre}{movie genre (Action & Adventure, Animation,
#'                Art House & International, Comedy, Documentary, Drama, Horror,
#'                Musical & Performing Arts, Mystery & Suspense, Other,
#'                Science Fiction & Fantasy)}
#'   \item{runtime}{length of film (in minutes)}
#'   \item{mpaa_rating}{G, NC-17, PG, PG-13, R, Unrated}
#'   \item{studio}{studio movie was filmed in}
#'   \item{thtr_rel_date}{Theatre release date}
#'   \item{thtr_rel_year}{Theatre release year}
#'   \item{thtr_rel_day}{Theatre release day}
#'   \item{dvd_rel_date}{DVD release date}
#'   \item{dvd_rel_year}{DVD release year}
#'   \item{dvd_rel_month}{DVD release month}
#'   \item{dvd_rel_day}{DVD release day}
#'   \item{imdb_rating}{IMDB rating}
#'   \item{imdb_num_votes}{IMDB number of votes}
#'   \item{critics_rating}{Critics rating}
#'   \item{critics_score}{Critics score}
#'   \item{audience_rating}{Audience rating}
#'   \item{audience_score}{Audience score}
#'   \item{best_pic_nom}{Best picture nomination?}
#'   \item{best_pic_win}{Best picture win?}
#'   \item{best_actor_win}{Best actor win?}
#'   \item{best_actress_win}{Best actrss win?}
#'   \item{best_dir_win}{Best director win?}
#'   \item{top200_box}{Top 200 box-office?}
#'   \item{director}{Film director name}
#'   \item{actor1}{Actor 1 name}
#'   \item{actor2}{Actor 2 name}
#'   \item{actor3}{Actor 3 name}
#'   \item{actor4}{Actor 4 name}
#'   \item{actor5}{Actor 5 name}
#'   \item{imdb_url}{IMDB website url}
#'   \item{rt_url}{Rotten Tomatoes website url}
#' }
"movies"
