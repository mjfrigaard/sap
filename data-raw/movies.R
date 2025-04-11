## code to prepare `movies.R` dataset goes here
# read in .RData file
load("data-raw/movies.RData")
# write out to .csv in inst/extdata/
vroom::vroom_write(movies, 
  file = "inst/extdata/movies.csv", 
  delim = ",")
# export to data/
usethis::use_data(movies, overwrite = TRUE)
