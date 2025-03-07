library(dplyr)
library(stringr)
library(vroom)
library(purrr)

base_path <- "inst/shiny-assist/imdb_data/"

import_imdb_data <- function(pth) {

  csv_files <- list.files(
    path = pth, 
    pattern = "\\.csv$", 
    full.names = TRUE, 
    recursive = TRUE
  )

    read_with_id <- function(file_path) {
        vroom::vroom(
          file_path,
          delim = ",", 
          id = "file_path",
          .name_repair = "unique") |> 
          dplyr::mutate(
            file = basename(file_path)
          )
    }

  imdb_datasets <- split(
    x = csv_files, 
    f = tools::file_path_sans_ext(basename(csv_files))
  ) |> 
    purrr::map(~ purrr::map_dfr(.x, read_with_id))  
  
  return(imdb_datasets)
  
}

imdb_data <- import_imdb_data(pth = base_path)

names(imdb_data)

imdb_data$`IMDB-actors` |> dplyr::glimpse()
imdb_data$`IMDB-directors` |> dplyr::glimpse()
