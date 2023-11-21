#' Month feedback (UI)
#'
#' @param id module ID
#'
#' @return module UI elements
#' 
#' @export
#'
monthFeedbackUI <- function(id) {
  textOutput(NS(id, "feedback"))
}

#' Month feedback (server)
#'
#' @param id module ID
#' @param month month input
#'
#' @return text feedback on month selection
#' 
#' @export
#'
monthFeedbackServer <- function(id, month) {
  stopifnot(is.reactive(month))

  moduleServer(id, function(input, output, session) {
    output$feedback <- renderText({
      if (month() == "October") {
        "You picked a great month!"
      } else {
        "Eh, you could do better."
      }
    })
  })
}