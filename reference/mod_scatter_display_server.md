# Scatter Plot Display Module - Server

Handles the server-side logic for rendering a scatter plot.

## Usage

``` r
mod_scatter_display_server(id, var_inputs, aes_inputs)
```

## Arguments

- id:

  *(character)* Namespace ID for the module.

- var_inputs:

  *(reactive)* A reactive expression containing user-selected variables.

- aes_inputs:

  *(reactive)* A reactive expression containing user-selected
  attributes.

## Value

No direct return value. This function generates a plot output.

## Details

`mod_scatter_display_server()`:

- Uses `var_inputs` to dynamically generate a scatter plot with
  user-selected variables.

- Reads from the `movies` dataset, which must be loaded in the app
  environment.

- Processes plot titles and axis labels to improve readability.

## Reactive Inputs

- `var_inputs()$x`: X-axis variable.

- `var_inputs()$y`: Y-axis variable.

- `var_inputs()$z`: Color aesthetic variable.

- `aes_inputs()$alpha`: Transparency level.

- `aes_inputs()$size`: Size of points.

- `aes_inputs()$plot_title`: Title of the plot.

## See also

- [`mod_var_input_server()`](https://mjfrigaard.github.io/sap/reference/mod_var_input_server.md)
  for variable selection.

- [`mod_aes_input_server()`](https://mjfrigaard.github.io/sap/reference/mod_aes_input_server.md)
  for aesthetics selection.

- [`scatter_plot()`](https://mjfrigaard.github.io/sap/reference/scatter_plot.md)
  for generating the scatter plot.

Other **Plot Display Module**:
[`mod_scatter_display_ui()`](https://mjfrigaard.github.io/sap/reference/mod_scatter_display_ui.md)
