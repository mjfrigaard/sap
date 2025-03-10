# Function for generating tooltip text (ggvis)
movie_tooltip <- function(x) {
  if (is.null(x)) {
    return(NULL)
  }
  if (is.null(x$ID)) {
    return(NULL)
  }
  # Pick out the movie with this ID
  all_movies <- isolate(all_movies())
  movie <- all_movies[all_movies$id == x$id, ]
  paste0(
    "<b>", movie$title, "</b><br>",
    movie$year, "<br>",
    "$", format(movie$box_office, big.mark = ",", scientific = FALSE)
  )
}

#' Create an Action Link
#'
#' This function generates an HTML link (`<a>` tag) that behaves like a button
#' in a Shiny application. It is useful for triggering reactive events without
#' using a traditional button UI element.
#'
#' @param inputId A character string specifying the ID of the action link,
#' which is used in the Shiny server function.
#' @param ... Additional attributes to be passed to the `<a>` tag, such as
#' label text or CSS styling.
#'
#' @return A `shiny.tag` object representing an HTML `<a>` element with
#' `action-button` class.
#'
action_link <- function(inputId, ...) {
  tags$a(
    href = "javascript:void",
    id = inputId,
    class = "action-button",
    ...
  )
}
