# Scatter Plot Display Module - UI

Creates a UI for displaying a scatter plot with user-selected options.

## Usage

``` r
mod_scatter_display_ui(id)
```

## Arguments

- id:

  *(character)* Namespace ID for the module.

## Value

A
[`shiny::tagList`](https://rstudio.github.io/htmltools/reference/tagList.html)
containing the plot output and metadata.

## Details

`mod_scatter_display_ui()` includes:

- A **scatter plot** created dynamically based on user input.

- Metadata about the app, including the data source.

## See also

- [`mod_scatter_display_server()`](https://mjfrigaard.github.io/sap/reference/mod_scatter_display_server.md)
  for the server-side logic of this module.

- [`scatter_plot()`](https://mjfrigaard.github.io/sap/reference/scatter_plot.md)
  for the utility function generating the plot.

Other **Plot Display Module**:
[`mod_scatter_display_server()`](https://mjfrigaard.github.io/sap/reference/mod_scatter_display_server.md)
