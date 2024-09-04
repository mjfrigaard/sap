library(shinytest2)
describe(
  "Feature 1: Scatter plot data visualization dropdowns
     As a film data analyst
     I want to explore movie review variables from IMDB (ggplot2movies::movies data)
     So that I can analyze relationships between movie attributes and ratings", {
  describe(
    "Scenario: Change dropdown values for plotting
        Given the movie review application is loaded
        When I choose the variable ['Length'] for the x-axis
        And I choose the variable ['Rating'] for the y-axis
        And I choose the variable ['Genre'] for the color
        And I click the ['Remove missing'] checkbox", code = {
    it("Then the scatter plot should show ['Length'] on the x-axis
        And the scatter plot should show ['Rating'] on the y-axis
        And the points on the scatter plot should be colored by ['Genre']
        And the missing values should be removed from the plot", {
            
    test_logger(start = 'ggp2movies-feat-01', msg = "update x, y, z, missing")
    app <- AppDriver$new(app_dir = system.file("dev", package = "sap"), 
                         name = "ggp2launch_app-feature-01", 
                         wait = FALSE, timeout = 60000,
                         height = 800, width = 1173)
      app$set_inputs(`vars-y` = "length")
      app$set_inputs(`vars-x` = "rating")
      app$set_inputs(`vars-z` = "genre")
      app$set_inputs(`plot-missing` = TRUE)
      app$expect_values()
      test_logger(end = 'ggp2movies-feat-01', msg = "update x, y, z, missing")
      })
   })
})
