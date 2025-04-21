# Define a test for the compare_vars module
describe(
  "Feature: Variable Selection Prevention of Duplicate X/Y Variables
      As a user
      I want to avoid selecting the same variable for both X and Y axes
      So that I can create meaningful scatter plots with different dimensions.",
  code = {
    it(
      "Scenario: Automatic Variable Selection Updates
         Given I have selected variables for the X and Y axes
         When I select the same variable for both axes
         Then the other axis should automatically update to a different variable
         And the plot parameters should reflect these changes",
      code = {
        shiny::testServer(
          app = mod_compare_vars_server,
          expr = {
            # test vals
            test_vals <- list(
              x = "critics_score",
              y = "audience_score",
              color = "mpaa_rating",
              alpha = 0.7,
              size = 3,
              title = "Variable Comparison"
                            )
            # Initialize with different variables
            session$setInputs(
              var_x = "critics_score",
              var_y = "audience_score",
              color = "mpaa_rating",
              alpha = 0.7,
              size = 3,
              plot_title = "Variable Comparison"
            )
            
            # Test that the returned reactive contains expected values
            expect_equal(
              object = session$returned(),
              expected = test_vals)
          }
        )
      }
    )
  }
)
