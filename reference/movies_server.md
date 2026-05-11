# Handles the server-side logic for the Movies Review application.

Handles the server-side logic for the Movies Review application.

## Usage

``` r
movies_server(input, output, session)
```

## Arguments

- input:

  The Shiny `input` object.

- output:

  The Shiny `output` object.

- session:

  The Shiny `session` object.

## Value

Defines server logic for reactive outputs and module integration.

## Details

The server integrates the following modules:

- **Variable Input Module**: Processes user input for scatter plot
  customization using
  [`mod_var_input_server()`](https://mjfrigaard.github.io/sap/reference/mod_var_input_server.md).

- **Plot Display Module**: Generates and displays a scatter plot based
  on user inputs using
  [`mod_scatter_display_server()`](https://mjfrigaard.github.io/sap/reference/mod_scatter_display_server.md).

## See also

- [`movies_ui()`](https://mjfrigaard.github.io/sap/reference/movies_ui.md)
  for the corresponding user interface.

- [`launch_app()`](https://mjfrigaard.github.io/sap/reference/launch_app.md)
  for the entry point of the application.

Other **Application Components**:
[`movies_ui()`](https://mjfrigaard.github.io/sap/reference/movies_ui.md)
