testthat::describe(
    "Feature: Movie Review Data Exploration App
  
       As a film data analyst
       I want to explore movie review data from IMDB.com
       So that I can analyze relationships between movie reivew metrics
  
     Background:
       Given I have launched the Movie Reviews Data Visualization App
       And I have data with IMDB and Rotten Tomatoes movie reviews
       And the data contains continuous variables like 'rating' 
       And the data contains categorical variables like 'mpaa'", 
       code = {
      
      testthat::it(
        "Scenario: Initial App Launch
           Given I have launched the movie review exploration app,
           When I view the scatter plot,
           Then I should see points representing values for a default
                set of continuous and categorical columns.", 
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