# Test for mod_counts_vars_server
describe(
  "Feature: Year Range Selection in Movie Counts Visualization
    As a user
    I want to select a range of years and a categorical variable
    So that I can analyze movie counts by that variable in the specified period.",
  code = {
    it(
      "Scenario: The module returns correct values when valid inputs are provided
        Given I have selected a valid year range
        And I have chosen a categorical variable
        When the module processes these inputs
        Then it should return the correct values for start_year, end_year, and chr_var",
      code = {
        shiny::testServer(
          app = mod_counts_vars_server,
          expr = {
            # test values 
            test_vals <- list(
                "start_year" = 2000,
                "end_year" = 2010,
                "chr_var" = "mpaa_rating"
                )
            # Set up our input values
            session$setInputs(
              start_year = 2000,
              end_year = 2010,
              chr_var = "mpaa_rating"
            )
            # Test that the reactive output returns the expected values
            expect_equal(
              object = session$returned(),
              expected = test_vals
            )
            session$setInputs(
              start_year = 1994,
              end_year = 2014
            )
            expect_equal(input$start_year, 1994)
            expect_equal(input$end_year, 2014)
          }
        )
      }
    )
  }
)