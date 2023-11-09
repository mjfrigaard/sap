# variable inputs 
make_var_inputs <- function() {
  glue::glue_collapse("list(y = 'audience_score', 
     x = 'imdb_rating',
     z = 'mpaa_rating',
     alpha = 0.5,
     size = 2,
     plot_title = 'Enter plot title'
    )")
}
# ggplot2movies::movies variable inputs 
make_ggp2_inputs <- function() {
glue::glue_collapse("list(x = 'avg_rating',
     y = 'length',
     z = 'mpaa',
     alpha = 0.75,
     size = 3,
     plot_title = 'Enter plot title'
     )"
  )
}

make_initial_rVals_inputs <- function() {
  rVals <- reactiveValues(
    inputs =
      reactive(list(
        x = "imdb_rating",
        y = "audience_score",
        z = "mpaa_rating",
        alpha = 0.5,
        size = 2,
        plot_title = "Enter Plot Title"
      ))
  )
  return(rVals)
}

make_changed_rVals_inputs <- function() {
  rVals <- reactiveValues(
    inputs =
      reactive(list(
        x = "critics_score",
        y = "imdb_num_votes",
        z = "genre",
        alpha = 0.75,
        size = 3,
        plot_title = "New plot title"
      ))
  )
  return(rVals)
}