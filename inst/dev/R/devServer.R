devServer <- function(input, output, session) {
  
  selected_vars <- moviesApp::mod_var_input_server("vars")

  dev_mod_scatter_server("plot", var_inputs = selected_vars)
  
}