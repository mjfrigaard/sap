describe(
  "Feature: Scatter plot data visualization
     As a film data analyst
     I want to explore movie review data
     So that I can examine relationships between movie reivew metrics
   Background:
     Given I have movie reviews data
     And the data contains continuous variables like 'IMDB rating'
     And the data contains categorical variables like 'mpaa'",
     code = {
    test_that(
      "Scenario: Scatter plot initial x, y, color values 
         When I launch the Scatter Plot Data Visualization
         And I have a IMDB dataset of movie reviews 
         Then the plot should show 'IMDB rating' on the x-axis
         And the plot should show 'Audience score' on the y-axis
         And the points on the plot should be colored by 'MPAA' rating", 
        code = {
          
    ggp2_scatter_inputs <- list(y = 'audience_score', 
                                x = 'imdb_rating',
                                z = 'mpaa_rating',
                                alpha = 0.5,
                                size = 2,
                                plot_title = 'Enter plot title')
    
    test_logger(start = "Step1", msg = "loading movies data")
    movies <- sap::movies
    test_logger(end = "Step1", msg = "movies data loaded successfully")
    
    test_logger(start = "Step2", msg = "creating graph")
    app_graph <- scatter_plot(movies,
      x_var = ggp2_scatter_inputs$x,
      y_var = ggp2_scatter_inputs$y,
      col_var = ggp2_scatter_inputs$z,
      alpha_var = ggp2_scatter_inputs$alpha,
      size_var = ggp2_scatter_inputs$size
    )
    test_logger(end = "Step2", msg = "graph created")
    
    expect_true(ggplot2::is.ggplot(app_graph))
  }) 

})
