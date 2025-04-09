# import testthat and ggplot2 function
box::use(
  testthat[describe, it, expect_equal, expect_true],
  ggplot2[is.ggplot]
)
# import data and plot modules
box::use(
  app / logic / data,
  app / logic / plot
)


describe("Feature: Scatter Plot Generation Verification
  As a data analyst,
  I want to ensure that scatter_plot() generates a valid scatter plot
  So that I can use it for visualizing relationships in movies data.", 
  code = {
  it("Scenario: Generating a scatter plot with specified parameters
    Given a function to import movies data
    And a function scatter_plot() from the plot module
    When I call scatter_plot() with movies data
    And specify x_var as 'critics_score'
    And specify y_var as 'imdb_rating'
    And specify col_var as 'mpaa_rating'
    And set alpha_var to 2 / 3
    And set size_var to 2
    Then the function should return a ggplot object with a scatter plot",
    code = {
    # call function to import movies data
    movies <- data$movies_data()
    # test point plot
    expect_true(
      is.ggplot(
          # call scatter_plot() from plot module
          plot$scatter_plot(
            df = movies,
            x_var = 'critics_score', 
            y_var = 'imdb_rating', 
            col_var = 'mpaa_rating', 
            alpha_var = 2 / 3,
            size_var = 2
          )
        )
      )
  })
})