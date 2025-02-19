library(shinytest2)
describe("Scenario A: Change dropdown values for plotting 
            Given the movie review application is loaded
            When I choose the variable [ ] for the x-axis
            And I choose the variable [ ] for the y-axis
            And I choose the variable [ ] for the color", {

  it("Then the scatter plot should show [ ] on the x-axis
        And the scatter plot should show [ ] on the y-axis
        And the points on the scatter plot should be colored by [ ]", {
  
          app <- AppDriver$new(name = "test-values",
                               height = 800, width = 1173,
                               wait = FALSE, timeout = 300000)

   test_values <- app$get_values()
   test_values[['export']]
  
  expect_equal(object = test_values[['export']]$`plot-alpha`, expected = 0.5)
  expect_equal(object = test_values[['export']]$`plot-size`, expected = 2)
  expect_equal(object = test_values[['export']]$`plot-title`, expected = "")
  expect_equal(object = test_values[['export']]$`plot-x`, expected = "imdb_rating")
  expect_equal(object = test_values[['export']]$`plot-y`, expected = "audience_score")
  expect_equal(object = test_values[['export']]$`plot-z`, expected = "mpaa_rating")

  })
})


