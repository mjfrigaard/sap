describe(
  "Feature: Scatter Plot Configuration in Movie Review Application
      As a user 
      I want the initial graph pre-configured with variables and aesthetics,
      So that I can change the inputs and see a meaningful visualization.", 
  code = {
  
  describe(
    "Background: Initial scatter plot x, y, color values 
         Given the movie review application is loaded
         And the scatter plot initial x-axis value is [IMDB Rating] 
         And the scatter plot initial y-axis value is [Audience Score]
         And the scatter plot initial color value is [MPAA Rating]
         And the initial opacity of the points is set to [0.5]
         And the initial size of the points is set to [2]
         And the initial plot title is set to [Enter plot title]", code = {
           
  it("Scenario: Changing scatter plot x, y, color values
       Given the movie review application is loaded
       When I choose the [Critics Score] variable for the x-axis
       And I choose the [Runtime] variable for the y-axis
       And I choose the [Title type] variable for color
       Then the scatter plot should show [Critics score] on the x-axis
       And the scatter plot should show [Runtime] on the y-axis
       And the points on the scatter plot should be colored by [Title type]
       And the opacity of the points should be set to [0.5]
       And the size of the points should be set to [2]
       And the plot title should be [Enter plot title]", code = {
    
  })
    shiny::testServer(app = mod_var_input_server, expr = {
      test_logger(start = "var_inputs", msg = "returned()")
      # set inputs
      session$setInputs(y = "imdb_rating",
                        x = "audience_score",
                        z = "mpaa_rating",
                        alpha = 0.5,
                        size = 2,
                        plot_title = "Enter plot title")
      testthat::expect_equal(object = session$returned(),
        expected = list(y = "imdb_rating",
                        x = "audience_score",
                        z = "mpaa_rating",
                        alpha = 0.5,
                        size = 2,
                        plot_title = "Enter plot title"))
      
      test_logger(end = "var_inputs", msg = "returned()")
      # flush reactives
      session$flushReact()
      
      test_logger(start = "var_inputs", msg = "updated returned()")
      # set inputs
      session$setInputs(y = "critics_score",
                        x = "runtime",
                        z = "title_type",
                        alpha = 0.5,
                        size = 2,
                        plot_title = "Enter plot title")

      testthat::expect_equal(object = session$returned(),
        expected = list(y = "critics_score",
                        x = "runtime",
                        z = "title_type",
                        alpha = 0.5,
                        size = 2,
                        plot_title = "Enter plot title"))
      
      test_logger(end = "var_inputs", msg = "updated returned()")
    })
  })
})