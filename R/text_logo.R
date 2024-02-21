#' Create a Text-based Logo in HTML
#'
#' `text_logo()` generates a text-based logo enclosed within HTML tags, allowing
#' for the specification of the heading size (h1 through h6). The logo features
#' a stylized representation of a face within arrows, using ASCII characters.
#'
#' @param size A character string specifying the heading size for the logo. 
#' Valid options include "h1", "h2", "h3", "h4", "h5", and "h6". 
#' Defaults to "h3".
#'
#' @return An HTML object containing the logo. This object can be directly used
#' in R Markdown documents or Shiny applications to render the logo in a web page.
#'
#' @examples
#' # Generate a logo with default size h3
#' text_logo()
#'
#' # Generate a logo with size h1
#' text_logo(size = "h1")
#'
#'
#' @export
text_logo <- function(size = 'h3') {
  if (any(size %in% c("h1", "h2", "h3", "h4", "h5", "h6"))) {
  htmltools::HTML(
    paste0(
    "<span>\n", 
      paste0("  <", size, ">", collapse = ""), "\n",
      "    <code>√\\/--‹(•_•)›--√\\/</code>\n", 
      paste0("  <", size, "/>", collapse = ""), "\n",
    "</span>\n"
      )
    )
  } else {
    rlang::abort(paste(size, "isnt supported", sep = " "))
  }
}