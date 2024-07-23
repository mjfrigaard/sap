describe(
  "Feature: Scatter plot data visualization
       As a film data analyst
       I want to explore movie review data from IMDB.com
       So that I can analyze relationships between movie reivew metrics",
  code = {
    describe(
      "Background:
          Given I have data with IMDB movie reviews
          And the data contains continuous variables like 'rating'
          And the data contains categorical variables like 'mpaa'",
      code = {
        it(
          "Scenario: Create scatter plot
              Given I have launched the movie review exploration app,
              When the scatter plot renders,
              Then the points on the x axis should represent 'Ratings'
              And the points on the y axis should represent 'Length'
              And the points should be colored by 'MPAA' rating
              And the size of the points should be set to '2'
              And the opacity of the points should be set to '0.5'",
          code = {
            # inputs
            ggp2_scatter_inputs <- list(x = "rating",
              y = "length",
              z = "mpaa",
              alpha = 0.75,
              size = 3,
              plot_title = "Enter plot title")
            # data fixture
            ggp2_movies <- readRDS(test_path(
              "fixtures",
              "tidy_ggp2_movies.rds"
            ))

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
})
