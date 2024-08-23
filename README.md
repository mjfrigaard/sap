<h1 align="center"> <code><strong>shinyrPkgs</strong></code> </h1>
  <h3 align="center"> Code examples for <a href="https://mjfrigaard.github.io/shiny-app-pkgs/"> Shiny App-Packages </a> </h3>
<hr>

# lap

The goal of `lap` is to demonstrate the `leprechaun` framework.

## Download

You can download [here](https://github.com/mjfrigaard/sfw/raw/main/_apps/lap.tar.gz).

## Run

You can run the application with the following:

``` r
library(lap)
lap::run()
```

## Tests 

The tests in this framework should result in the following (on the **2nd call to `devtools::test()`**)


```
==> devtools::test()

ℹ Testing lap
Loading required package: shiny
✔ | F W  S  OK | Context
✔ |          2 | app-feature-01 [11.8s]                                                                                  
✔ |          1 | module_plot_display                                                                                     
✔ |          2 | module_var_input                                                                                        
✔ |          1 | shinytest2 [6.4s]                                                                                       
✔ |          1 | utils_scatter_plot                                                                                      

══ Results ═════════════════════════════════════════════════════════════════════
Duration: 18.5 s

[ FAIL 0 | WARN 0 | SKIP 0 | PASS 7 ]
```
