## code to prepare `stones` dataset goes here
library(vroom)
stones <- vroom::vroom("birthstones.csv")
usethis::use_data(stones, overwrite = TRUE)
