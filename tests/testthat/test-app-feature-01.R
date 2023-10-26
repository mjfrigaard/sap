library(shinytest2)
describe("Feature 1: Scatter plot data visualization dropdowns
           As a film data analyst
           I want to explore variables in the movie review data
           So that I can analyze relationships between movie reivew sources", {
             
  describe("Scenario A: Change dropdown values for plotting
             Given the movie review application is loaded
             When I choose the variable [ ] for the x-axis
             And I choose the variable [ ] for the y-axis
             And I choose the variable [ ] for the color", {
        it("Then the scatter plot should show [ ] on the x-axis
             And the scatter plot should show [ ] on the y-axis
             And the points on the scatter plot should be colored by [ ]", {
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
              When I choose the size of the points to be [ ]
              And I choose the opacity of the points to be [ ]
              And I enter '[ ]' for the plot title", {
         it("Then the size of the points on the scatter plot should be [ ]
              And the opacity of the points on the scatter plot should be [ ]
              And the title of the plot should be '[ ]'", {
              app <- AppDriver$new(name = "feature-01-senario-b", 
                                     height = 800, width = 1173)
                app$set_inputs(`vars-alpha` = 0.7)
                app$set_inputs(`vars-size` = 3)
                app$set_inputs(`vars-plot_title` = "New plot title")
                app$expect_values()
        })
      })
})