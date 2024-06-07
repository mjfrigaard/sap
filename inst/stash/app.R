library(shiny)
library(ggplot2)
library(bslib)
library(moviesApp)
library(dplyr)

num_data <- movies[c(
  "runtime", "imdb_rating", "imdb_num_votes",
  "critics_score", "audience_score"
)]

chr_data <- movies[c("mpaa_rating", "genre", "critics_rating")]


ui <- page_navbar(
  title = "Movies Data",
  fillable = "Metrics",
  nav_panel(
    "Metrics",
    card(
      layout_sidebar(
        sidebar = sidebar(
          class = "p-0",
          markdown("Select Inputs"),
          varSelectInput(
            inputId = "var_x",
            label = "X variable",
            data = num_data,
            selected = "imdb_rating"
          ),
          varSelectInput(
            inputId = "var_y",
            label = "Y variable",
            data = num_data,
            selected = "critics_score"
          ),
          varSelectInput(
            inputId = "color",
            label = "Color by:",
            data = chr_data,
            selected = "critics_rating"
          )
        ),
        card_body(
          class = "p-0",
          markdown("Scatter Plot"),
          plotOutput("scatter")
        )
      )
    )
  ),
  nav_panel(
    "By Year",
    navset_card_tab(
      # full_screen = TRUE,
      # layout_sidebar(
      sidebar =
        sidebar(
          class = "p-0",
          # markdown("`by year sidebar`"),
          numericInput(
            inputId = "year",
            label = "Theater Release Year",
            value = 1980,
            min = min(movies["thtr_rel_year"]$thtr_rel_year),
            max = max(movies["thtr_rel_year"]$thtr_rel_year),
            step = 1
          )
        ),
      nav_panel(
        markdown("Genre"),
        plotOutput("genre")
      ),
      nav_panel(
        markdown("Ratings"),
        plotOutput("rating")
      ),
      nav_panel(
        markdown("Table"),
        tableOutput(outputId = "year_tbl")
      )
    )
  )
  # )
)

server <- function(input, output) {
  
  output$genre <- renderPlot({
    genre_data <- subset(
      movies,
      thtr_rel_year == input$year
    )
    ggplot(data = genre_data, aes(genre)) +
      geom_bar() +
      coord_flip() +
      labs(y = "# of Movies", x = "Genre") +
      ggplot2::theme_minimal()
  })

  output$rating <- renderPlot({
    rating_data <- subset(
      movies,
      thtr_rel_year == input$year
    )
    ggplot(rating_data, aes(mpaa_rating)) +
      geom_bar() +
      labs(y = "# of Movies", x = "MPAA Rating") +
      ggplot2::theme_minimal()
  })

  output$year_tbl <- renderTable({
    tbl_data <- subset(movies,
      thtr_rel_year == input$year,
      select = c("title", "studio", "director")
    ) |>
      setNames(c("Title", "Studio", "Director"))
    tbl_data
  })

  output$scatter <- renderPlot({
    req(input$var_x, input$var_y, input$color)
    ggplot(data = movies) +
      aes(
        y = !!input$var_y,
        x = !!input$var_x,
        color = !!input$color
      ) +
      geom_point() +
      ggplot2::theme_minimal() +
      ggplot2::theme(legend.position = "right")
  })
}

shinyApp(ui = ui, server = server)
