library(shinytest2)
testthat::describe(
  "Feature 1: Scatter plot data visualization dropdowns
     As a film data analyst
     I want to explore continuous and categorical variables in the movie review data
     So that I can analyze relationships between movie reivew metrics", code = {
  testthat::it("Scenario: Change dropdown values for plotting
                 Given the movie review application is loaded
                 When I choose the variable 'IMDB number of votes' for the x-axis
                 And I choose the variable 'Critics Score' for the y-axis
                 And I choose the variable 'Genre' for the color
                 And I choose the size of the points to be 3
                 And I choose the opacity of the points to be 0.7
                 Then the scatter plot should show 'IMDB number of votes' on the x-axis
                 And the scatter plot should show 'Critics Score' on the y-axis
                 And the points on the scatter plot should be colored by 'Genre'
                 And the size of the points on the scatter plot should be 3
                 And the opacity of the points on the scatter plot should be 0.7
                 And the title of the plot should be 'New Plot Title'", code = {
    test_logger(start = 'feature-01', msg = "Change x/y/z, size, alpha, title")
    app <- AppDriver$new(name = "moviesApp-feature-01", height = 800, width = 1173)
    app$set_inputs(`vars-y` = "imdb_num_votes")
    app$set_inputs(`vars-x` = "critics_score")
    app$set_inputs(`vars-z` = "genre")
    app$set_inputs(`vars-alpha` = 0.7)
    app$set_inputs(`vars-size` = 3)
    app$set_inputs(`vars-plot_title` = "New plot title")
    app$expect_values()
    test_logger(end = 'feature-01', msg = "Change x/y/z, size, alpha, title")
  })
})


