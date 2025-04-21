# Testing the counts vertical box module server
describe(
  "Feature: Movie Count Display in Date Range
   As a user
   I want to see the number of movies and year span for a selected date range
   So that I can understand the dataset coverage for my selection.",
  code = {
    it(
      "Scenario: Displaying movie counts and year span for a date range
       Given I have selected a date range from 2000 to 2010
       When the counts box module processes this selection
       Then it should display the correct number of unique movies
       And it should show the correct year span",
      code = {
        # Mock the logr_msg function to avoid errors in testing
        logr_msg <- function(msg, level) { }
        
        shiny::testServer(
          app = mod_counts_vbox_server,
          args = list(
            vals = shiny::reactive(
              list(
                start_year = 2000,
                end_year = 2010
              )
            )
          ),
          expr = {
            # Test that filtered_data contains the correct subset of movies
            expect_equal(
              object = nrow(filtered_data()),
              expected = sum(movies$thtr_rel_year >= 2000 & 
                  movies$thtr_rel_year <= 2010)
            )
            
            # Test that counts_text output shows the correct number of movies
            expected_movie_count <- length(unique(
              subset(movies, 
                thtr_rel_year >= 2000 & 
                  thtr_rel_year <= 2010)$imdb_url
            ))
            
            # Test that years_text output shows the correct year span
            expected_year_span <- 10 # 2010 - 2000 = 10
            
            # Verify output texts
            expect_equal(
              object = {
                session$flushReact()
                list(
                  movie_count = output$counts_text,
                  year_span = output$years_text
                )
              },
              expected = list(
                movie_count = paste(expected_movie_count, "movies"),
                year_span = paste(expected_year_span, "years")
              )
            )
          }
        )
      }
    )
  }
)
