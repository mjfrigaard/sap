make_var_inputs <- function() {
  glue::glue_collapse("list(y = 'audience_score', 
     x = 'imdb_rating',
     z = 'mpaa_rating',
     alpha = 0.5,
     size = 2,
     plot_title = 'Enter plot title'
    )")
}

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

test_logger <- function(msg, start = NULL, end = NULL) {
  if (is.null(start) & is.null(end)) {
    cat("\n")
    logger::log_info("{msg}")
  } else if (!is.null(start) & is.null(end)) {
    cat("\n")
    logger::log_info("\n[ START {start} = {msg}]")
  } else if (is.null(start) & !is.null(end)) {
    cat("\n")
    logger::log_info("\n[ END {end} = {msg}]")
  } else {
    cat("\n")
    logger::log_info("\n[ START {start} = {msg}]")
    cat("\n")
    logger::log_info("\n[ END {end} = {msg}]")
  }
}