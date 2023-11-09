#' Test logger (test utility)
#'
#' @param start test start message 
#' @param end test end message 
#' @param msg test message 
#'
#' @return message to test output
#'
test_logger <- function(start = NULL, end = NULL, msg) {
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

#' Make initial `reactiveValues()` for module test
#' 
#' Used for testing [mod_scatter_display_server()]
#'
#' @return reactive test values
#' 
#' @export
#' 
#' @examples
#' require(shiny)
#' rVals <- make_initial_rVals_inputs()
#' isolate(rVals$inputs())
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

#' Make changed `reactiveValues()` for module test
#' 
#' Used for testing [mod_scatter_display_server()]
#'
#' @return reactive test values
#' 
#' @export
#' 
#' @examples
#' require(shiny)
#' rVals <- make_changed_rVals_inputs()
#' isolate(rVals$inputs())
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