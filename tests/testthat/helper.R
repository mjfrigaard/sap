# load packages --------------------
library(tidyr)
library(dplyr)
library(stringr)
library(purrr)
library(waldo)

make_var_inputs <- function() {
  glue::glue_collapse("list(y = 'audience_score', 
     x = 'imdb_rating',
     z = 'mpaa_rating',
     alpha = 0.5,
     size = 2,
     plot_title = 'Enter plot title'
    )")
}

make_ggp2_inputs <- function() {
glue::glue_collapse("list(x = 'avg_rating',
     y = 'length',
     z = 'mpaa',
     alpha = 0.75,
     size = 3,
     plot_title = 'Enter plot title'
     )"
  )
}

base_tidy_movies <- function() {
  
  # movies_data <- ggplot2movies::movies
  movies_data <- head(ggplot2movies::movies, 100)
  
  # Add row_id column
  movies_data$row_id <- seq_len(nrow(movies_data))
  # Reshape the data
  long_data <- reshape(data = movies_data,
                       varying = c("Action", "Animation", 
                         "Comedy", "Drama", "Documentary", 
                         "Romance", "Short"),
                       v.names = "genre_value",
                       times = c("Action", "Animation", 
                         "Comedy", "Drama", "Documentary",
                         "Romance", "Short"),
                       timevar = "genres",
                       direction = 'long',
                       idvar = c("title", "year", "length"))
  return(long_data)
  # Rows: 411,516
  # Columns: 20
  
  # Convert genre_value to logical
  # long_data$genre_value <- as.logical(long_data$genre_value)

  # Filter rows where genre_value is 0
  # filtered_data <- subset(x = long_data, genre_value == 1)
  # filtered_data <- filtered_data[order(filtered_data$title, 
  #                               decreasing = TRUE), ]
  
  
  # Rows: 65,134
  # Columns: 20
  
  # # Group by row_id and collapse genres
  # aggregated_data_base <- aggregate(genres ~ row_id + title, 
  #                              filtered_data, paste, collapse = ", ")
  # # Rows: 46,002
  # # Columns: 2
  # 
  # # Merge with original data to keep other columns
  # tidy_data <- merge(x = movies_data, y = aggregated_data_base, 
  #                    by = "row_id", all = TRUE)
  # 
  # # Rows: 58,788
  # # Columns: 26
  # 
  # # Remove duplicate rows
  # tidy_data <- unique(tidy_data)
  # # Rows: 58,788
  # # Columns: 26
  # 
  # # Reorder columns
  # tidy_data <- tidy_data[ , c("title", "length", "year",
  #                             "budget", "rating", "votes",
  #                             "mpaa", "genres")]
  # 
  # # Convert genres and mpaa to factors
  # tidy_data$genres <- factor(tidy_data$genres)
  # tidy_data$mpaa <- factor(tidy_data$mpaa,
  #                           levels = c("G", "PG", "PG-13", "R", "NC-17"),
  #                           labels = c("G", "PG", "PG-13", "R", "NC-17"))
  # # Sort by title
  # # tidy_data <- tidy_data[order(tidy_data$title), ]
  # return(tidy_data)
}

bdat <- base_tidy_movies() 

tidy_movies <- function() {
  
  # movies_data <- ggplot2movies::movies
  movies_data <- head(ggplot2movies::movies, 100)
  
  # Add row_id column
  movies_data <- dplyr::mutate(movies_data,
    row_id = 1:nrow(movies_data)
  )
  
  long_data <- tidyr::pivot_longer(data = movies_data, 
                                  cols = c(Action:Short),
                                  names_to = "genres",
                                  values_to = "genre_value")
  return(long_data)
  # Rows: 411,516
  # Columns: 19
  
  # long_data <- dplyr::mutate(long_data,
  #   genre_value = as.logical(genre_value))
  
  # filtered_data <- dplyr::filter(long_data,
  #                                genre_value == 1)
  # filtered_data <- dplyr::arrange(filtered_data, desc(title))
  
  # Rows: 65,134
  # Columns: 19
  
  
  # aggregated_data_tidy <- dplyr::group_by(filtered_data, title) |>
  # dplyr:::mutate(
  #   genres = paste0(genre_key, collapse = ", ")
  # ) |>
  # dplyr::ungroup()
  # 
  # # Rows: 65,134
  # # Columns: 20
  # 
  # distinct_data <- dplyr::distinct(aggregated_data_tidy, .keep_all = TRUE)
  # 
  # # Rows: 65,134
  # # Columns: 20
  # 
  # columns_data <- dplyr::mutate(distinct_data,
  #   genres = dplyr::na_if(x = genres, ""),
  #   genre = dplyr::case_when(
  #               stringr::str_detect(genres, ",") ~ 'Multiple genres',
  #               TRUE ~ genres),
  #   genre = factor(genre),
  #   mpaa = dplyr::na_if(x = mpaa, y = ""),
  #   mpaa = factor(mpaa,
  #     levels = c("G", "PG", "PG-13", "R", "NC-17"),
  #     labels = c("G", "PG", "PG-13", "R", "NC-17"))
  #   )
  # tidy_data <- dplyr::select(columns_data,
  #   title, -genre, length, year,
  #   budget, rating, votes, mpaa
  # )
  # return(tidy_data)
}

tdat <- tidy_movies() 

waldo::compare(x = names(bdat), y = names(tdat))

waldo::compare(x = unique(bdat$title), y = unique(tdat$title))


combo_tidy_movies <- function() {

  movies_data <- ggplot2movies::movies

  movies_data$row_id <- 1:nrow(movies_data)

  # Convert to long format
  long_data <- reshape(
    movies_data,
    direction = "long",
    # action to short are columns 18 to 24
    varying = list(
      c("Action",
        "Animation",
        "Comedy",
        "Drama",
        "Documentary",
        "Romance",
        "Short")),
    v.names = "genre_value",
    # action to short are columns 18 to 24
    times = c("Action",
              "Animation",
              "Comedy",
              "Drama",
              "Documentary",
              "Romance",
              "Short"),
    idvar = c("title", "year"),
    timevar = "genres"
  )

  long_data <- long_data[c('row_id', 'title', 'year',
                           'length', 'budget', 'rating',
                           'votes', 'mpaa', 'genres',
                           'genre_value')]

  long_data |>
    dplyr::mutate(genre_value = as.logical(genre_value)) |>
    dplyr::filter(genre_value == TRUE) |>
    dplyr::group_by(row_id) |>
    dplyr:::mutate(
      genres = paste0(genres, collapse = ", ")
    ) |>
    dplyr::ungroup() |>
    dplyr::distinct(title, .keep_all = TRUE) |>
      dplyr::select(
      title, length, year, budget,
      rating, votes, mpaa, genres
    ) |>
    dplyr::mutate(
      genres = dplyr::na_if(x = genres, ""),
      genres = factor(genres),
      mpaa = dplyr::na_if(x = mpaa, y = ""),
      mpaa = factor(mpaa,
        levels = c("G", "PG", "PG-13", "R", "NC-17"),
        labels = c("G", "PG", "PG-13", "R", "NC-17")
      )
    ) |>
    dplyr::arrange(title)
}

