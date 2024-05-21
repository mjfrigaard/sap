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
        "Rating" = "avg_rating",
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
        "Rating" = "avg_rating",
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
    ),
    sliderInput(
      inputId = ns("alpha"),
      label = "Alpha:",
      min = 0, max = 1, step = 0.1,
      value = 0.4
    ),
    sliderInput(
      inputId = ns("size"),
      label = "Size:",
      min = 0, max = 5, step = 0.5,
      value = 2.5
    )
  )
}