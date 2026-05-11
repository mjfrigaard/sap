# Aesthetics Input Module - UI

Creates a UI for selecting attributes for a scatter plot.

## Usage

``` r
mod_aes_input_ui(id)
```

## Arguments

- id:

  *(character)* Namespace ID for the module.

## Value

A
[`shiny::tagList()`](https://rstudio.github.io/htmltools/reference/tagList.html)
containing UI elements for variable selection.

## Details

`mod_aes_input_ui()` provides UI controls for customizing scatter plots.
It includes:

- **Sliders**:

  - Transparency (`alpha`) ranging from 0 to 1.

  - Point size ranging from 0 to 5.

- **Text Input**:

  - Plot title.

The function uses [`shiny::NS()`](https://rdrr.io/pkg/shiny/man/NS.html)
to namespace all input IDs.

## See also

- [`mod_aes_input_server()`](https://mjfrigaard.github.io/sap/reference/mod_aes_input_server.md)
  for server-side logic.

- [[`shiny::tagList()`](https://rstudio.github.io/htmltools/reference/tagList.html)](https://shiny.rstudio.com/reference/shiny/latest/tagList.html)
  for containing UI elements.

- [[`shiny::NS()`](https://rdrr.io/pkg/shiny/man/NS.html)](https://shiny.rstudio.com/reference/shiny/latest/NS.html)
  for namespacing.
