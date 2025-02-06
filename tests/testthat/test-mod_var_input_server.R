describe(
  "Feature: Scatter Plot Configuration in Movie Review Application
      As a user
      I want the initial graph pre-configured with variables,
      So that I can change the inputs and see a meaningful visualization.",
  code = {
    describe(
      "Background: Initial scatter plot x, y, color values
         Given the movie review application is launched
         And the initial x-axis value is [IMDB Rating]
         And the initial y-axis value is [Audience Score]
         And the initial color value is [MPAA Rating]",
      code = {
        it("Scenario: Changing scatter plot x, y, and color values
             Given the movie review application is launched
             When I choose the [Critics Score] for the x-axis
             And I choose the [Runtime] for the y-axis
             And I choose the [Title type] for color
             Then the scatter plot should show [Critics score] on the x-axis
             And the scatter plot should show [Runtime] on the y-axis
             And the points on the scatter plot should be colored by [Title type]", 
          code = {
          
            shiny::testServer(app = mod_var_input_server, expr = {

              test_vals <- list(
                x = "audience_score",
                y = "imdb_rating",
                z = "mpaa_rating")

              test_logger(start = "RETURNED", msg = "test_vals vs. session$returned()")
              
              session$setInputs(
                x = "audience_score",
                y = "imdb_rating",
                z = "mpaa_rating")

              expect_equal(
                object = session$returned(),
                expected = test_vals)
            
              test_logger(end = "RETURNED", msg = "test_vals vs. session$returned()")
              
              session$flushReact()
              
          })
        })
      }
    )
  }
)
