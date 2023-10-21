testthat::describe(
  "F1.2: Dropdown menus (continuous x & y axes, categorical point coloration)", 
  code = {
  
  testthat::it(
    "Scenario: Scatter plot initial x, y, color values 
      When I launched the Scatter Plot Data Visualization
      And I have a dataset of movie reviews from IMDB and Rotten Tomatoes
      Then the scatter plot should show 'IMDB Rating' on the x-axis
      And the scatter plot should show 'Audience Score' on the y-axis
      And the points on the scatter plot should be colored by 'MPAA Rating'", code = {
    shiny::testServer(app = mod_var_input_server, expr = {
      
      test_logger(start = "T5", msg = "F1.2: returned()")
      
      # create list of expected test values 
      test_vals <- list(y = "imdb_rating",
                        x = "audience_score",
                        z = "mpaa_rating",
                        alpha = 0.75,
                        size = 3,
                        plot_title = "Example title")

      # set inputs
      session$setInputs(y = "imdb_rating",
                        x = "audience_score",
                        z = "mpaa_rating",
                        alpha = 0.75,
                        size = 3,
                        plot_title = "Example title")

      testthat::expect_equal(
        object = session$returned(),
        expected = test_vals
      )

      test_logger(end = "T5", msg = "F1.2: returned()")
      
    })
  })
})