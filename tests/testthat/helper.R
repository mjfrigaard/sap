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
