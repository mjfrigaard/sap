#' Generate Row Style Based on Value
#'
#' Applies background color styling to a table row based on the given value.
#' The function assigns specific background colors for various categorical values
#' typically found in film ratings or genres, enhancing the visual representation
#' of data tables.
#'
#' @param value A character string representing the categorical value for which 
#'   a corresponding background color is applied. Supported values include 
#'   "Certified Fresh", "Fresh", "Rotten", "Upright", "Spilled", film genres 
#'   like "Action & Adventure", "Animation", "Art House & International", 
#'   and MPAA ratings like "G", "PG", "PG-13", "R", "NC-17", "Unrated". 
#'   An unrecognized value will result in a default background color.
#'
#' @return A list with a single element, `background`, containing the hex code 
#'   for the corresponding background color.
#'
#' @examples
#' react_tbl_row_style("Certified Fresh")
#' react_tbl_row_style("Action & Adventure")
#' react_tbl_row_style("PG-13")
#' react_tbl_row_style("Unknown Category")
#'
#' @export
react_tbl_row_style <- function(value) {
  switch(as.character(value),
         "Certified Fresh" = list(background = "#FC5C64FF"),
         "Fresh" = list(background = "#2F8AC4FF"),
         "Rotten" = list(background = "#99C945FF"),
         "Upright" = list(background = "#FC5C64FF"),
         "Spilled" = list(background = "#2F8AC4FF"),
         "Action & Adventure" = list(background = "#FC5C64FF"),
         "Animation" = list(background = "#2F8AC4FF"),
         "Art House & International" = list(background = "#99C945FF"),
         "Comedy" = list(background = "#E58606FF"),
         "Drama" = list(background = "#5D69B1FF"),
         "Documentary" = list(background = "#CC61B0FF"),
         "Horror" = list(background = "#24796CFF"),
         "Musical & Performing Arts" = list(background = "#DAA51BFF"),
         "Mystery & Suspense" = list(background = "#2F8AC4FF"),
         "Science Fiction & Fantasy" = list(background = "#764E9FFF"),
         "Feature Film" = list(background = "#FC5C64FF"),
         "Documentary" = list(background = "#2F8AC4FF"),
         "TV Movie" = list(background = "#99C945FF"),
         "G" = list(background = "#E58606FF"),
         "PG" = list(background = "#5D69B1FF"),
         "PG-13" = list(background = "#CC61B0FF"),
         "R" = list(background = "#24796CFF"),
         "NC-17" = list(background = "#DAA51BFF"),
         "Unrated" = list(background = "#2F8AC4FF"),
         list(background = "#A5AA99FF")  # Default color
  )
}


