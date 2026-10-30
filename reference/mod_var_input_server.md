# Variable Input Module - Server

Handles the server-side logic for the variable input module.

## Usage

``` r
mod_var_input_server(id)
```

## Arguments

- id:

  *(character)* Namespace ID for the module.

## Value

A **reactive expression** that returns a list of selected input values:

- `y`: Variable for the y-axis.

- `x`: Variable for the x-axis.

- `z`: Variable for the point colors.

## Details

`mod_var_input_server()` reads user input from the corresponding UI
function created with
[`mod_var_input_ui()`](https://mjfrigaard.github.io/sap/reference/mod_var_input_ui.md).
It processes and returns a reactive object containing the selected
variables.

## See also

- [`mod_var_input_ui()`](https://mjfrigaard.github.io/sap/reference/mod_var_input_ui.md)
  for the UI counterpart of this module.

- [`mod_scatter_display_server()`](https://mjfrigaard.github.io/sap/reference/mod_scatter_display_server.md)
  for displaying the scatter plot.

Other **Variable Input Module**:
[`mod_var_input_ui()`](https://mjfrigaard.github.io/sap/reference/mod_var_input_ui.md)

## Examples

``` r
if (interactive()) {
  shiny::shinyApp(
    ui = shiny::fluidPage(mod_var_input_ui("vars")),
    server = function(input, output, session) {
      selected_vars <- mod_var_input_server("vars")
      shiny::observe(print(selected_vars()))
    }
  )
}

```
