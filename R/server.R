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
				  text = "this message is from your R/server.R file")

  ## New code -->
   selected_vars <- var_input_server("vars")

   plot_display_server("plot", var_inputs = selected_vars)

   ## New code <--

}
