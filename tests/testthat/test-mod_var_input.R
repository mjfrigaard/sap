describe(
  "Feature: Scatter Plot Configuration in Movie Review Application
    As a user who accesses the movie review application,
    I want the initial scatter plot pre-configured with variables and aesthetics,
    So that I can immediately see a meaningful visualization.", 
  code = {
  
  it(
    "Scenario: Scatter plot initial x, y, color values 
         Given the movie review application is loaded
         When I view the initial scatter plot
         Then the scatter plot should show 'IMDB Rating' on the x-axis
         And the scatter plot should show 'Audience Score' on the y-axis
         And the points on the scatter plot should be colored by 'MPAA Rating'
         And the size of the points should be set to '2'
         And the opacity of the points should be set to '0.5'", code = {
    shiny::testServer(app = mod_var_input_server, expr = {
      
      test_logger(start = "input", msg = "initial inputs returned()")

      # set inputs
      session$setInputs(y = "imdb_rating",
                        x = "audience_score",
                        z = "mpaa_rating",
                        alpha = 0.5,
                        size = 2,
                        plot_title = "Enter plot title")

      expect_equal(
        object = session$returned(),
        expected = list(y = "imdb_rating",
                        x = "audience_score",
                        z = "mpaa_rating",
                        alpha = 0.5,
                        size = 2,
                        plot_title = "Enter plot title")
      )

      test_logger(end = "input", msg = "initial inputs returned()")
      
    })
  })
})