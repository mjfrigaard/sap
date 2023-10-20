testthat::describe(
    "F1.2-1.4: Dropdown menus (continuous x & y axes, categorical point coloration)", 
       code = {
testthat::it(
  "Scenario: Scatter plot initial x, y, color values 
    When I launched the Scatter Plot Data Visualization
    And I have a dataset of movie reviews from IMDB 
    Then the scatter plot should show 'Rating' on the x-axis
    And the scatter plot should show 'Length' on the y-axis
    And the points on the scatter plot should be colored by 'MPAA' rating", 
          code = {
    # inputs
        ggp2_scatter_inputs <- list(
          x = "rating",
          y = "length",
          z = "mpaa",
          alpha = 0.75,
          size = 3,
          plot_title = "Enter plot title"
        )
        # data fixture
    ggp2_movies <- readRDS(test_path("fixtures",
                            "tidy_ggp2_movies.rds"))
    app_graph <- scatter_plot(ggp2_movies,
      x_var = ggp2_scatter_inputs$x,
      y_var = ggp2_scatter_inputs$y,
      col_var = ggp2_scatter_inputs$z,
      alpha_var = ggp2_scatter_inputs$alpha,
      size_var = ggp2_scatter_inputs$size
    )
    expect_true(ggplot2::is.ggplot(app_graph))
  })

})