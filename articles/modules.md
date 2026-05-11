# App Modules

``` r

library(sap)
library(lobstr) # abstract syntax trees
```

## Variable inputs

``` default
█─launch_app 
├─█─display_type 
├─█─movies_ui 
│ └─█─mod_var_input_ui 
└─█─movies_server 
  └─█─mod_var_input_server 
```

## Aesthetic inputs

``` default
█─launch_app 
├─█─display_type 
├─█─movies_ui 
│ ├─█─mod_var_input_ui 
│ └─█─mod_aes_input_ui 
└─█─movies_server 
  ├─█─mod_var_input_server 
  └─█─mod_aes_input_server
```

## Scatter plot display

``` default
█─launch_app 
├─█─display_type 
├─█─movies_ui 
│ ├─█─mod_var_input_ui 
│ ├─█─mod_aes_input_ui 
│ └─█─mod_scatter_display_ui 
└─█─movies_server 
  ├─█─mod_var_input_server 
  ├─█─mod_aes_input_server 
  └─█─mod_scatter_display_server 
    └─█─scatter_plot 
```
