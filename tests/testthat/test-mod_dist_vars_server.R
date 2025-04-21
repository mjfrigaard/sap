# Test for mod_dist_vars_server function
describe(
  "Feature: Distribution variables selection in the distribution module
    As a user
    I want to select numeric and categorical variables with aesthetics
    So that I can control what is displayed in distribution plots",
  code = {
    it(
      "Scenario: User selects variables and aesthetics
        Given the distribution module is loaded
        When I select 'budget' as numeric variable
        And I select 'mpaa_rating' as categorical variable
        And I set alpha to 0.7
        And I set point size to 3
        Then these selections should be correctly captured in the return value",
      code = {
        shiny::testServer(
          app = mod_dist_vars_server,
          expr = {
            test_vals <- list(
              num_var = "audience_score",
              chr_var = "mpaa_rating",
              alpha = 0.7,
              size = 3)
            # Simulate user inputs
            session$setInputs(
              num_var = "audience_score",
              chr_var = "mpaa_rating",
              alpha = 0.7,
              size = 3
            )
            # Test that the reactive returns expected values
            expect_equal(
              object = session$returned(),
              expected = test_vals
            )
          }
        )
      }
    )
  }
)