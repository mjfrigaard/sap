testthat::describe(
  "F1.2: Dropdown menus (continuous x & y axes, categorical point coloration)",
  code = { 
    
testthat::it(
  "Scenario: Scatter plot initial x, y, color values 
    When I launched the Scatter Plot Data Visualization
    And I have a dataset of movie reviews from IMDB and Rotten Tomatoes
    Then the scatter plot should show 'IMDB Rating' on the x-axis
    And the scatter plot should show 'Audience Score' on the y-axis
    And the points on the scatter plot should be colored by 'MPAA Rating' 
  ", code = {

    test_logger(start = "T2", msg = "Tests F1.2 initial x/y/z variables")
                  
    scatter_inputs <- list(x = 'imdb_rating',
                       y = 'audience_score',
                       z = 'mpaa_rating',
                       alpha = 0.5,
                       size = 2,
                       plot_title = 'Enter plot title')
    
    vdiffr::expect_doppelganger(
      title = "FR12-FR14: initial x y z axes", 
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
    
    test_logger(end = "T2", msg = "Tests F1.2 initial x/y/z variables")
    
  })
  
  testthat::it(
  "Scenario: Change x, y, color values for plotting
    When I launched the Scatter Plot Data Visualization
    And I choose the variable 'Audience Score' for the x-axis
    And I choose the variable 'IMDB Rating' for the y-axis
    And I choose the variable 'Critics Rating' for the color 
    Then the scatter plot should show 'Audience Score' on the x-axis
    And the scatter plot should show 'IMDB Rating' on the y-axis
    And the points on the scatter plot should be colored by 'Critics Rating' 
  ", code = {

    test_logger(start = "T3", msg = "Tests FR1.4 & FR1.5 update x/y/z")
    
    scatter_inputs <- list(x = 'audience_score',
                       y = 'imdb_rating', 
                       z = 'critics_rating',
                       alpha = 0.5,
                       size = 2,
                       plot_title = 'Enter plot title')
    
    vdiffr::expect_doppelganger(
      title = "FR14-FR15: update x, y, color", 
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
        
    test_logger(end = "T3", msg = "Tests FR1.4 & FR1.5 update x/y/z")
    
  })
  
})