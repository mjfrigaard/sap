## code to prepare `movies` dataset goes here
load("data-raw/movies.RData")
# also export this to a .csv for downloading by URL
vroom::vroom_write(x = movies, file = "data-raw/movies.csv", delim = ",")
# export for package use
usethis::use_data(movies, overwrite = TRUE)
