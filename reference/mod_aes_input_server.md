# Aesthetics Input Module - Server

Handles the server-side logic for the variable input module.

## Usage

``` r
mod_aes_input_server(id)
```

## Arguments

- id:

  *(character)* Namespace ID for the module.

## Value

A **reactive expression** that returns a list of selected input values:

- `alpha`: Transparency level of points (0-1).

- `size`: Size of the points.

- `plot_title`: Title for the scatter plot.

## Details

`mod_aes_input_server()` reads user input from the corresponding UI
function created with
[`mod_aes_input_ui()`](https://mjfrigaard.github.io/sap/reference/mod_aes_input_ui.md).
It processes and returns a reactive object containing the selected plot
attributes.

## See also

- [`mod_aes_input_ui()`](https://mjfrigaard.github.io/sap/reference/mod_aes_input_ui.md)
  for the UI counterpart of this module.

- [`mod_scatter_display_server()`](https://mjfrigaard.github.io/sap/reference/mod_scatter_display_server.md)
  for displaying the scatter plot.
