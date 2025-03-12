# db_app_server.R
db_app_server <- function(input, output, session) {
  
  # Set up handles to database tables on app start
  # db <- dplyr::src_sqlite(path = 'movies.db')
  # omdb <- dplyr::tbl(db, 'omdb')
  # tomatoes <- dplyr::tbl(db, 'tomatoes')
  db <- connect_database(pkg = "sap", db = "movies.db")
  
  # Join tables, filter out those with <10 reviews, and select
  # all_movies <- dplyr::inner_join(omdb, tomatoes, by = "ID") |>
  #   dplyr::filter(Reviews >= 10) |>
  #   dplyr::select(
  #     ID, imdbID, Title, Year, Rating_m = Rating.x, Runtime, Genre,
  #     Released, Director, Writer, imdbRating, imdbVotes, Language,
  #     Country, Oscars, Rating = Rating.y, Meter, Reviews, Fresh, Rotten,
  #     userMeter, userRating, userReviews, BoxOffice, Production, Cast
  #   )
  all_movies <- get_all_movies(db = db)
  
  # Call module for inputs
  inputs_reactive <- mod_graph_inputs_server(
    id = "graph_inputs",
    all_movies = all_movies
  )
  
  # Call module for outputs
  mod_graph_output_server(
    id = "graph_outputs",
    inputs_list = inputs_reactive
  )
}