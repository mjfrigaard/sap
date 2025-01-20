devServer <- function(input, output, session) {
  
  selected_vars <- sap::mod_var_input_server("vars")

  selected_aes <- sap::mod_aes_input_server("aes")

  dev_mod_scatter_server("plot", 
                        var_inputs = selected_vars,
                        aes_inputs = selected_aes)
  
}
