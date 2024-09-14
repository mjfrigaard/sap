describe(
  "Feature: Scatter plot data visualization
     As a film data analyst
     I want to explore IMDB.com movie review data 
     So that I can examine relationships between movie review metrics
   Background:
     Given I have IMDB movie reviews data  
     And the data contains continuous variables like 'rating'
     And the data contains categorical variables like 'mpaa'", 
     code = {
    it(
      "Scenario: Scatter plot initial x, y, color values 
         When I launch the Scatter Plot Data Visualization
         And I have a IMDB dataset of movie reviews 
         Then the plot should show 'Rating' on the x-axis
         And the plot should show 'Length' on the y-axis
         And the points on the plot should be colored by 'MPAA' rating", 
        code = {
    ggp2_scatter_inputs <- list(
          x = "rating",
          y = "length",
          z = "mpaa",
          alpha = 0.75,
          size = 3,
          plot_title = "Enter plot title"
        )
    tidy_ggp2_movies <- readRDS(test_path("fixtures",
                                "tidy_ggp2_movies.rds"))
    app_graph <- scatter_plot(tidy_ggp2_movies,
      x_var = ggp2_scatter_inputs$x,
      y_var = ggp2_scatter_inputs$y,
      col_var = ggp2_scatter_inputs$z,
      alpha_var = ggp2_scatter_inputs$alpha,
      size_var = ggp2_scatter_inputs$size
    )
    expect_true(ggplot2::is.ggplot(app_graph))
  }) 
})