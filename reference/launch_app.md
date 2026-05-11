# Launch the Movies Review Application

Starts the Movies Review Shiny application, which provides a
customizable scatter plot interface for analyzing movie data.

## Usage

``` r
launch_app(app = NULL, options = list(), run = "p", ...)
```

## Arguments

- app:

  which app to run. Options are:

  - `NULL` = the default app (`"movies"`)

  - `"bslib"` = alternative `bslib` layout

  - `"ggp2"` = `ggplot2movies` (tidy) data app.

  - `"quarto"` = Quarto movies app.

- options:

  arguments to pass to
  [`options()`](https://rdrr.io/r/base/options.html)

- run:

  where to launch app:

  - `p` = launch in viewer pane

  - `b` = launch in external browser

  - `w` = launch in window

- ...:

  arguments passed to UI

## Value

A **Shiny application** object.

## Details

See the [ggplot2movies](https://github.com/hadley/ggplot2movies)
package.

## Details

The application uses:

- **UI**: Defined in
  [`movies_ui()`](https://mjfrigaard.github.io/sap/reference/movies_ui.md).

- **Server Logic**: Defined in
  [`movies_server()`](https://mjfrigaard.github.io/sap/reference/movies_server.md).

## See also

- [`movies_ui()`](https://mjfrigaard.github.io/sap/reference/movies_ui.md)
  for the user interface.

- [`movies_server()`](https://mjfrigaard.github.io/sap/reference/movies_server.md)
  for the server logic.
