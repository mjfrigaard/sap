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
      
      test_logger(start = "T4", msg = "initial returned()")

      # set inputs
      session$setInputs(y = "imdb_rating",
                        x = "audience_score",
                        z = "mpaa_rating",
                        alpha = 0.5,
                        size = 2,
                        plot_title = "Enter plot title")

      testthat::expect_equal(
        object = session$returned(),
        expected = list(y = "imdb_rating",
                        x = "audience_score",
                        z = "mpaa_rating",
                        alpha = 0.5,
                        size = 2,
                        plot_title = "Enter plot title")
      )

      test_logger(end = "T4", msg = "initial returned()")
      
    })
  })
})