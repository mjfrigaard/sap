library(shinytest2)
describe("Feature 1: Scatter plot data visualization dropdowns
           As a film data analyst
           I want to explore variables in the movie review data
           So that I can analyze relationships between movie reivew sources", {
             
  describe("Scenario A: Change dropdown values for plotting
             Given the movie review application is loaded
             When I choose the variable [critics_score] for the x-axis
             And I choose the variable [imdb_num_votes] for the y-axis
             And I choose the variable [genre] for the color", {
        it("Then the scatter plot should show [critics_score] on the x-axis
             And the scatter plot should show [imdb_num_votes] on the y-axis
             And the points on the scatter plot should be colored by [genre]", {
              app <- AppDriver$new(name = "feature-01-senario-a", 
                                     height = 800, width = 1173)
                app$set_inputs(`vars-y` = "imdb_num_votes")
                app$set_inputs(`vars-x` = "critics_score")
                app$set_inputs(`vars-z` = "genre")
                app$expect_values()
       })
     })
             
  describe("Scenario B: Change dropdown values for plotting
              Given the movie review application is loaded
              When I choose the size of the points to be [3]
              And I choose the opacity of the points to be [0.7]
              And I enter '[New plot title]' for the plot title", {
         it("Then the size of the points on the scatter plot should be [3]
              And the opacity of the points on the scatter plot should be [0.7]
              And the title of the plot should be '[New plot title]'", {
              app <- AppDriver$new(name = "feature-01-senario-b", 
                                     height = 800, width = 1173)
                app$set_inputs(`vars-alpha` = 0.7)
                app$set_inputs(`vars-size` = 3)
                app$set_inputs(`vars-plot_title` = "New plot title")
                app$expect_values()
        })
      })
})