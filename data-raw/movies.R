## code to prepare `movies` dataset goes here
# library(fst)
movies <- fst::read_fst(path = "inst/extdata/movies.fst")
# store as plain text file for easier sharing
write.csv(x = movies, file = "inst/extdata/movies.csv")
