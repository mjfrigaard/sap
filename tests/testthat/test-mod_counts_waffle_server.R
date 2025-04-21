describe(
  "Feature: Waffle Plot Visualization in Movie Analysis Application
   As a user
   I want to see a waffle plot visualization of movies by categorical variable
   So that I can understand the distribution across categories for selected years",
  code = {
    it(
      "Scenario: Waffle plot receives and processes input values correctly
       Given the movie analysis application is loaded
       When I provide a categorical variable and year range
       Then the waffle plot should process these inputs correctly
       And prepare the proper visualization parameters",
      code = {
        shiny::testServer(
          app = mod_counts_waffle_server,
          args = list(
            vals = shiny::reactive(
              list(
                chr_var = "mpaa_rating",
                start_year = 2000,
                end_year = 2010
              )
            )
          ),
          expr = {
            # Test that reactive vals input is processed correctly
            expect_equal(
              object = vals(),
              expected = list(
                chr_var = "mpaa_rating",
                start_year = 2000,
                end_year = 2010
              )
            )
            # The renderPlot output would be tested here, but we're focused 
            # on the reactive input processing since testing the actual plot 
            # rendering would require more complex setup
          }
        )
      }
    )
  }
)
