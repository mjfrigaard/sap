## code to prepare `movies` dataset goes here
load("data/movies.rda")
# store as plain text file for easier sharing
vroom::vroom_write(x = movies,
          file = "inst/extdata/movies.csv", 
          delim = ",")
