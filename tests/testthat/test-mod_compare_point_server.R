# Test for mod_compare_point_server

describe(
  "Feature: Movie comparison scatter plot rendering
   As a user
   I want to see a scatter plot comparing two movie variables with color coding
   So that I can visualize relationships between multiple movie attributes",
  code = {
    it(
      "Scenario: Rendering a scatter plot with proper labels and formatting
       Given I have selected movie comparison variables
       When the scatter plot module processes these selections
       Then it should transform variable names into proper case for labels
       And create appropriate title and subtitle for the visualization",
      code = {
        shiny::testServer(
          app = mod_compare_point_server,
          args = list(
            vals = shiny::reactive(
              list(
                x = "critics_score",
                y = "imdb_rating",
                color = "mpaa_rating",
                title = "movie comparison",
                subtitle = "critics score vs. imdb rating and mpaa rating"
              )
            )
          ),
          expr = {
            expect_equal(
              object = vals(),
              expected = list(
                x = "critics_score",
                y = "imdb_rating",
                color = "mpaa_rating",
                title = "movie comparison",
                subtitle = "critics score vs. imdb rating and mpaa rating"
              )
            )
            # Test that label_inputs() correctly formats the variable names
            expect_equal(
              object = label_inputs(),
              expected = list(
                x = "Critics Score",
                y = "Imdb Rating",
                color = "Mpaa Rating",
                title = "Movie Comparison",
                subtitle = "Critics Score vs. Imdb Rating and Mpaa Rating"
              )
            )
          }
        )
      }
    )
  }
)
