## Chat args

```r
chat <- chat_openai(model = "o1", 
	system_prompt = "
  You are an expert Shiny developer and R package author. Return responses in
  markdown.
  
  Follow the tidyverse style guide:
  * Limit code to 80 characters per line   
  * File names should be machine readable (no spaces, symbols, or special 
    characters)   
  * Variables and function names should all be `snake_case` (i.e., lowercase
    letters, numbers, and underscores to separate words within a name).   
  * Place a space before and after `=`   
  * Avoid empty lines at the start or end of functions   
  * Only use a single empty line when needed to separate functions or pipes   
  * Use verbs for function names   
  * If a function name and definition can’t fit on a single line, indent the
    argument name with a single indent (i.e. two spaces).   
  * Comments should be in sentence case   
  * Spread long function calls across multiple lines    
  * Always use double quotes for strings   
  * Use double quotes, not single quotes, for quoting text   
  * Use base pipe `|>` (not `%>%`)    
  ")
```

## Prompt text

```r
chat$chat("
Convert the following code into two utility functions for 1) establishing a 
connection to the `movies.db` database, and 2) joining the omdb and tomatoes
tables, filtering to `Reviews >= 10`, and selecting the necessary columns.

\`\`\`r
db_con.R 
# Set up handles to database tables on app start
db <- dplyr::src_sqlite(path = 'movies.db')
omdb <- dplyr::tbl(db, 'omdb')
tomatoes <- dplyr::tbl(db, 'tomatoes')
\`\`\`


\`\`\`r
# Join tables, filter out those with <10 reviews, and select
all_movies <- dplyr::inner_join(omdb, tomatoes, by = 'ID') |>
dplyr::filter(Reviews >= 10) |>
dplyr::select(
    ID, imdbID, Title, Year, Rating_m = Rating.x, Runtime, Genre,
    Released, Director, Writer, imdbRating, imdbVotes, Language,
    Country, Oscars, Rating = Rating.y, Meter, Reviews, Fresh, Rotten,
    userMeter, userRating, userReviews, BoxOffice, Production, Cast
)
\`\`\`

")
```

## Response

```r
# db_utils.R

connect_database <- function(db_path = "movies.db") {
  # Create a handle to the movies database
  db <- dplyr::src_sqlite(path = db_path)
  db
}

get_all_movies <- function(db) {
  # Join tables, filter out those with <10 reviews, and select columns
  omdb <- dplyr::tbl(db, "omdb")
  tomatoes <- dplyr::tbl(db, "tomatoes")
  
  all_movies <- dplyr::inner_join(
    x = omdb,
    y = tomatoes,
    by = "ID"
  ) |>
    dplyr::filter(Reviews >= 10) |>
    dplyr::select(
      ID, imdbID, Title, Year, Rating_m = Rating.x, Runtime, Genre,
      Released, Director, Writer, imdbRating, imdbVotes, Language,
      Country, Oscars, Rating = Rating.y, Meter, Reviews,
      Fresh, Rotten, userMeter, userRating, userReviews, BoxOffice,
      Production, Cast
    )
  
  all_movies
}
```

Explanation  
• `connect_database()` is a simple function that uses `dplyr::src_sqlite()` to connect  
  to the `movies.db` SQLite database, returning the database connection object.  
• `get_all_movies()` pulls the `omdb` and `tomatoes` tables, joins them, filters for  
  `Reviews ≥ 10`, and selects the required columns.