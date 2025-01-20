dev_mod_vars_ui <- function(id) {
  ns <- NS(id)
  tagList(
    textInput(
      inputId = ns("plot_title"),
      label = "Plot title",
      placeholder = "Enter plot title"
    ),
    selectInput(
      inputId = ns("y"),
      label = "Y-axis:",
      choices = c(
        "Year" = "year",
        "Length" = "length",
        "Budget" = "budget",
        "Rating" = "rating",
        "Votes" = "votes"
      ),
      selected = "budget"
    ),
    selectInput(
      inputId = ns("x"),
      label = "X-axis:",
      choices = c(
        "Year" = "year",
        "Length" = "length",
        "Budget" = "budget",
        "Rating" = "rating",
        "Votes" = "votes"
      ),
      selected = "year"
    ),
    selectInput(
      inputId = ns("z"),
      label = "Color by:",
      choices = c(
        "MPAA" = "mpaa",
        "Genre" = "genre"
      ),
      selected = "mpaa"
    )
  )
}