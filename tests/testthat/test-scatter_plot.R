testthat::describe(
  "Feature: Scatter plot data visualization
       As a film data analyst
       I want to explore movie review data from IMDB.com
       So that I can analyze relationships between movie reivew metrics",
  code = {
    testthat::describe(
      "Background:
          Given I have data with IMDB movie reviews
          And the data contains continuous variables like 'rating'
          And the data contains categorical variables like 'mpaa'",
      code = {
        testthat::it(
          "Scenario: Create scatter plot
              Given I have launched the movie review exploration app,
              When the scatter plot renders,
              Then the points on the x axis should represent 'Ratings'
              And the points on the y axis should represent 'Length'
              And the points should be colored by 'MPAA' rating",
          code = {
            test_logger(start = "T1", msg = "Create ggplot2 object")
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
            test_logger(end = "T1", msg = "Create ggplot2 object")
        })
    })
})
testthat::describe(
  "Feature 1.2: Scatter Plot Configuration in Movie Review Application
    As a user who accesses the movie review application,
    I want the initial scatter plot pre-configured with variables and aesthetics,
    So that I can immediately see a meaningful visualization.",
  code = { 
    
  testthat::it(
    "Scenario: Displaying the Pre-configured Initial Scatter Plot
      Given the movie review application is loaded
      When I view the initial scatter plot
      Then the x-axis should display the 'IMDB Rating'
      And the y-axis should display the 'Audience Score'
      And the points should be colored by 'MPAA Rating'
      And the size of the points should be set to '2'
      And the opacity of the points should be set to '0.5'", code = {

    test_logger(start = "T2", msg = "Tests initial x/y/z")
                  
    scatter_inputs <- list(x = 'imdb_rating',
                       y = 'audience_score',
                       z = 'mpaa_rating',
                       alpha = 0.5,
                       size = 2,
                       plot_title = 'Enter plot title')
    
    vdiffr::expect_doppelganger(
      title = "Initial x y z axes", 
      fig = scatter_plot(movies, 
        x_var = scatter_inputs$x, 
        y_var = scatter_inputs$y, 
        col_var = scatter_inputs$z, 
        alpha_var = scatter_inputs$alpha, 
        size_var = scatter_inputs$size) + 
        ggplot2::labs( 
          title = scatter_inputs$plot_title, 
          x = stringr::str_replace_all( 
                tools::toTitleCase( 
                  scatter_inputs$x), "_", " "), 
          y = stringr::str_replace_all( 
                tools::toTitleCase( 
                  scatter_inputs$y), "_", " ") 
        ) + 
        ggplot2::theme_minimal() + 
        ggplot2::theme(legend.position = "bottom"))
    
    test_logger(end = "T2", msg = "Tests initial x/y/z")
    
  })
  
  testthat::it(
  "Scenario: Change x, y, color values for plotting
    When I launch the Scatter Plot Data Visualization
    And I select the variable 'Audience Score' for the x-axis
    And I select the variable 'IMDB Rating' for the y-axis
    And I select the variable 'Critics Rating' for the color 
    Then the scatter plot should show 'Audience Score' on the x-axis
    And the scatter plot should show 'IMDB Rating' on the y-axis
    And the points on the scatter plot should be colored by 'Critics Rating' 
  ", code = {

    test_logger(start = "T3", msg = "Tests updated x/y/z")
    
    scatter_inputs <- list(x = 'audience_score',
                       y = 'imdb_rating', 
                       z = 'critics_rating',
                       alpha = 0.5,
                       size = 2,
                       plot_title = 'Enter plot title')
    
    vdiffr::expect_doppelganger(
      title = "Updated x, y, color", 
      fig = scatter_plot(movies, 
        x_var = scatter_inputs$x, 
        y_var = scatter_inputs$y, 
        col_var = scatter_inputs$z, 
        alpha_var = scatter_inputs$alpha, 
        size_var = scatter_inputs$size) + 
        ggplot2::labs( 
          title = scatter_inputs$plot_title, 
          x = stringr::str_replace_all( 
                tools::toTitleCase( 
                  scatter_inputs$x), "_", " "), 
          y = stringr::str_replace_all( 
                tools::toTitleCase( 
                  scatter_inputs$y), "_", " ")) + 
        ggplot2::theme_minimal() + 
        ggplot2::theme(legend.position = "bottom"))
        
    test_logger(end = "T3", msg = "Tests updated x/y/z")
    
  })
  
})