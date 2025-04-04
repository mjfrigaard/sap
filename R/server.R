#' Server
#'
#' Core server function.
#'
#' @param input,output Input and output list objects
#' containing said registered inputs and outputs.
#' @param session Shiny session.
#'
#' @noRd
#' @keywords internal
server <- function(input, output, session){

	send_message <- make_send_message(session)

  send_message("show-packer",
              text = "a message from R/server.R")

  selected_vars <- vars_server("vars")

  selected_aes <- aes_server("aes")

  scatter_display_server("plot",
                         var_inputs = selected_vars,
                         aes_inputs = selected_aes)

}
