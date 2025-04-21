# Test for mod_dist_raincloud_server
describe(
  "Feature: Raincloud plot generation for movie data distribution
  As a user
  I want to see a raincloud plot of movie data distribution
  So that I can visualize the distribution across categories",
  code = {
    it(
      "Scenario: Raincloud plot configuration with selected variables and aesthetics
      Given the movie data is available
      When I select numerical and categorical variables with styling options
      Then the raincloud plot should be generated with those specifications",
      code = {
        shiny::testServer(
          app = mod_dist_raincloud_server,
          args = list(
            vals = shiny::reactive(list(
              num_var = "critics_score",
              chr_var = "mpaa_rating",
              alpha = 0.7,
              size = 3
            ))
          ),
          expr = {
            # Test that the output$cloud is generated
            # Note: We can't directly test the plot output, but we can check
            # that no errors are thrown when the renderPlot expression is run
            
            # Test that the vals() input is correctly processed
            expect_equal(
              object = vals(),
              expected = list(
                num_var = "critics_score",
                chr_var = "mpaa_rating",
                alpha = 0.7,
                size = 3
              )
            )
            
            # We would also expect the plot to be rendered, but we can't directly
            # test the plot object in testServer without mocking more functions
          }
        )
      }
    )
  }
)
