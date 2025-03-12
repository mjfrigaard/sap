#' Establish a Database Connection
#'
#' This function connects to an SQLite database within an R package's
#'  `extdata` directory.
#'
#' @param pkg A character string specifying the name of the R package where
#' the database file is located.
#' @param db A character string specifying the name of the SQLite database
#' file (e.g., `"movies.db"`).
#'
#' @return A `DBIConnection` object representing the connection to the database.
#'
#' @export
#'
db_con <- function(pkg, db) {
  # Set up handles to database tables on app start
  con <- DBI::dbConnect(RSQLite::SQLite(),
                      system.file("extdata", db, package = pkg))
}
