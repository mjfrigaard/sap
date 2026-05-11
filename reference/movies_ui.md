# User Interface for the Movies Review Application

Creates the user interface (UI) for the Movies Review application, which
allows users to create customizable scatter plots based on movie data.

## Usage

``` r
movies_ui(bslib = FALSE)
```

## Arguments

- bslib:

  View bslib logo?

## Value

A Shiny `tagList` object containing the UI elements.

## Details

The interface is built using [`bslib`](https://rstudio.github.io/bslib/)

- **Page (fillable)**:
  [[`bslib::page_fillable()`](https://rstudio.github.io/bslib/reference/page_fillable.html)](https://rstudio.github.io/bslib/reference/page_fillable.html)
  displays the app title.

- **Sidebar**:
  [[`bslib::layout_sidebar()`](https://rstudio.github.io/bslib/reference/sidebar.html)](https://rstudio.github.io/bslib/reference/sidebar.html)
  includes a logo and the variable selection module.
  ([`mod_var_input_ui`](https://mjfrigaard.github.io/sap/reference/mod_var_input_ui.md)).

- **Card**:
  [[`bslib::card()`](https://rstudio.github.io/bslib/reference/card.html)](https://rstudio.github.io/bslib/reference/card.html)
  displays the scatter plot module
  ([`mod_scatter_display_ui`](https://mjfrigaard.github.io/sap/reference/mod_scatter_display_ui.md)).

## See also

- [`movies_server()`](https://mjfrigaard.github.io/sap/reference/movies_server.md)
  for the server logic of the app.

- [`mod_var_input_ui()`](https://mjfrigaard.github.io/sap/reference/mod_var_input_ui.md)
  and
  [`mod_scatter_display_ui()`](https://mjfrigaard.github.io/sap/reference/mod_scatter_display_ui.md)
  for the modules included in the UI.

Other **Application Components**:
[`movies_server()`](https://mjfrigaard.github.io/sap/reference/movies_server.md)
