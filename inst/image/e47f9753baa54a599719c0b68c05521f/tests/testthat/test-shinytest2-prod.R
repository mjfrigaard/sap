library(shinytest2)
describe(
  "Feature 1: Scatter plot data visualization dropdowns
     As a film data analyst
     I want to explore movie review variables 
     So that I can analyze relationships between movie attributes and ratings", {
  describe(
    "Scenario: Change dropdown values for plotting
        Given the movie review application is loaded
        When I choose the variable ['Critics Score'] for the x-axis
        And I choose the variable ['IMDB number of votes'] for the y-axis
        And I choose the variable ['Genre'] for the color", code = {
    it("Then the scatter plot should show ['Critics Score'] on the x-axis
        And the scatter plot should show ['IMDB number of votes'] on the y-axis
        And the points on the scatter plot should be colored by ['Genre']", {
            
    test_logger(start = 'prod-feat-01', msg = "update x, y, and z")
      
    app <- AppDriver$new(system.file("prod/app", package = "sap"), 
                         name = "prod-feat-01", 
                         wait = FALSE, timeout = 3000,
                         height = 800, width = 1173)
    
          app$set_inputs(`vars-y` = "imdb_num_votes")
          app$set_inputs(`vars-x` = "critics_score")
          app$set_inputs(`vars-z` = "genre")
          app$set_inputs(`aes-alpha` = 0.7)
          app$set_inputs(`aes-size` = 3)
          app$set_inputs(`aes-plot_title` = "New plot title")

          app$expect_values()
          
      test_logger(end = 'prod-feat-01', msg = "update x, y, and z")
      
      })
   })
})