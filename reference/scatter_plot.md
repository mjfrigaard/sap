# Create scatter plot

Custom [`ggplot2`](https://ggplot2.tidyverse.org/) function for building
scatter plots in `sap`.

## Usage

``` r
scatter_plot(df, x_var, y_var, col_var, alpha_var, size_var)
```

## Arguments

- df:

  *(data.frame)* The dataset containing the variables to plot.

- x_var:

  *(character)* Name of the variable for the x-axis.

- y_var:

  *(character)* Name of the variable for the y-axis.

- col_var:

  *(character)* Name of the variable for the color aesthetic.

- alpha_var:

  *(numeric)* Transparency level of points (0 to 1).

- size_var:

  *(numeric)* Size of points.

## Value

A `ggplot` object representing the scatter plot.

## Details

`scatter_plot()` is designed for use in Shiny applications but can also
be used independently. It supports customization of transparency, size,
and color aesthetics.

## See also

- [`mod_scatter_display_server()`](https://mjfrigaard.github.io/sap/reference/mod_scatter_display_server.md)
  for integrating this function into the scatter plot module.

- [[`ggplot2::ggplot()`](https://ggplot2.tidyverse.org/reference/ggplot.html)](https://ggplot2.tidyverse.org/)
  for details on `ggplot2` usage.

Other **Utility Functions**:
[`log_message()`](https://mjfrigaard.github.io/sap/reference/log_message.md)

## Examples

``` r
scatter_plot(
  df = mtcars,
  x_var = "mpg",
  y_var = "hp",
  col_var = "cyl",
  alpha_var = 0.7,
  size_var = 3
)

```
