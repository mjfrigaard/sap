connect_database <- function(pkg, db) {
  # Create a handle to the movies database
  con <- DBI::dbConnect(RSQLite::SQLite(),
              system.file("extdata", db, package = pkg))
  con
}