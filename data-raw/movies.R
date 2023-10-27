## code to prepare `movies` dataset goes here
load("inst/extdata/movies.RData")
usethis::use_data(movies, overwrite = TRUE)
