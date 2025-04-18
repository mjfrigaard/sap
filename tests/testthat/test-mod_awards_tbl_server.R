# Testing a Shiny module that renders a reactable table
# This test focuses on the award table module which receives a reactive input
testthat::describe(
  "Feature: Movie Awards Table Display
  As a user
  I want to see a table of movie awards based on my filter selections
  So that I can analyze award-winning films within specific timeframes",
  code = {
    testthat::it(
      "Scenario: Displaying Oscar winners between 2010-2020
      Given I select 'Oscar' as the award type
      And I select '2010' as the start year
      And I select '2020' as the end year
      When the table renders
      Then I should see a table of Oscar winners from 2010-2020
      And the table should have properly formatted column names",
      code = {
        # Setup mock input values as a reactive expression
        mock_vals <- reactive(list(
          award = "Films",
          start_year = 2010,
          end_year = 2020
        ))
        # Test the server module with mock inputs
        shiny::testServer(
          app = mod_awards_tbl_server,
          args = list(vals = mock_vals),
          expr = {
            # Test that output is created
            expect_true(!is.null(output$awards_table))
            
            # Mock the create_movie_awards function to avoid database calls
            mockr::with_mock(
              create_movie_awards = function(award, start_year, end_year) {
                # Return a simple mock dataset
                data.frame(
                  movie_title = c("Film A", "Film B", "Film C"),
                  award_year = c(2010, 2015, 2020),
                  award_category = c("Best Picture", "Best Actor", "Best Actress"),
                  stringsAsFactors = FALSE
                )
              },
              {
                # Force execution of the renderReactable expression
                table_output <- output$awards_table
                
                # Verify the table output exists and has expected structure
                expect_true(is.list(table_output))
                
                # Test that column names were properly formatted (name_case function)
                expect_equal(
                  table_output$x$tag$attribs$data$names,
                  c("Movie Title", "Award Year", "Award Category")
                )
                
                # Test reactable configuration
                expect_equal(table_output$x$tag$attribs$bordered, FALSE)
                expect_equal(table_output$x$tag$attribs$highlight, TRUE)
                expect_equal(table_output$x$tag$attribs$striped, TRUE)
                expect_equal(table_output$x$tag$attribs$compact, TRUE)
              }
            )
          }
        )
      }
    )
    
    testthat::it(
      "Scenario: Handling errors in award table generation
      Given I provide invalid award parameters
      When the table tries to render
      Then it should handle the error gracefully
      And display an empty table instead of crashing",
      code = {
        # Setup mock input with values that will trigger an error
        mock_invalid_vals <- reactive(list(
          award = "InvalidAward",
          start_year = 2010,
          end_year = 2020
        ))
        
        # Test the server module with invalid inputs
        shiny::testServer(
          app = mod_awards_tbl_server,
          args = list(vals = mock_invalid_vals),
          expr = {
            # Mock the create_movie_awards function to throw an error
            mockr::with_mock(
              create_movie_awards = function(award, start_year, end_year) {
                stop("Invalid award type")
              },
              {
                # Force execution of the renderReactable expression
                table_output <- output$awards_table
                
                # Verify we get an empty reactable instead of an error
                expect_true(is.list(table_output))
                expect_equal(nrow(table_output$x$tag$attribs$data), 0)
              }
            )
          }
        )
      }
    )
  }
)