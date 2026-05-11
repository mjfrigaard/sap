# Create a Text-based Logo in HTML

`text_logo()` generates a text-based logo enclosed within HTML tags,
allowing for the specification of the heading size (h1 through h6). The
logo features a stylized representation of a face within arrows, using
ASCII characters.

## Usage

``` r
text_logo(size = "h3")
```

## Arguments

- size:

  A character string specifying the heading size for the logo. Valid
  options include "h1", "h2", "h3", "h4", "h5", and "h6". Defaults to
  "h3".

## Value

An HTML object containing the logo. This object can be directly used in
R Markdown documents or Shiny applications to render the logo in a web
page.

## Examples

``` r
# Generate a logo with default size h3
text_logo()
#> <span>
#>   <h3>
#>     <code>√\/--‹(•_•)›--√\/</code>
#>   <h3/>
#> </span>
#> 

# Generate a logo with size h1
text_logo(size = "h1")
#> <span>
#>   <h1>
#>     <code>√\/--‹(•_•)›--√\/</code>
#>   <h1/>
#> </span>
#> 
```
