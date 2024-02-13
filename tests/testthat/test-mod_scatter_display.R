# this should be loaded with devtools::load_all() 
# source("helper.R")
# but it's not...
testthat::describe(
  "Feature: Scatter Plot Configuration in Movie Review Application
      As a user 
      I want the initial graph pre-configured with variables and aesthetics,
      So that I can immediately see a meaningful visualization.",
  code = {
    testthat::it(
      "Scenario: Scatter plot initial x, y, color values 
         Given the movie review application is loaded
         When I view the initial scatter plot
         Then the scatter plot should show 'IMDB Rating' on the x-axis
         And the scatter plot should show 'Audience Score' on the y-axis
         And the points on the scatter plot should be colored by 'MPAA Rating'
         And the size of the points should be set to '2'
         And the opacity of the points should be set to '0.5'
         And the plot title should be 'Enter plot title'",
      code = {
        shiny::testServer(app = mod_scatter_display_server,
          args = list(rVals = make_initial_rVals_inputs()), expr = {
            test_logger(start = "display", msg = "selected_vars initial values")
            testthat::expect_equal(
              object = rVals$inputs(),
              expected = list(
                    x = "imdb_rating",
                    y = "audience_score",
                    z = "mpaa_rating",
                    alpha = 0.5,
                    size = 2,
                    plot_title = "Enter Plot Title"
                )
            )
            test_logger(end = "display", msg = "selected_vars initial values")
          })
      })
  })


testthat::describe(
  "Feature: Scatter plot data visualization outputs
     As a user
     I want to explore continuous and categorical variables in the movie review data
     So that I can analyze relationships between movie reivew metrics
    
  Scenario: Change x, y, color values for plotting
     Given the movie review application is loaded
     When I choose the variable 'IMDB number of votes' for the x-axis
     And I choose the variable 'Critics Score' for the y-axis
     And I choose the variable 'Genre' for the color
     And I choose the size of the points to be 3
     And I choose the opacity of the points to be 0.7
     And I choose the title of the plot to be 'New plot title'", code = {
       
  testthat::it("Then the scatter plot should show 'IMDB number of votes' on the x-axis
                And the scatter plot should show 'Critics Score' on the y-axis
                And the points on the scatter plot should be colored by 'Genre'
                And the size of the points on the scatter plot should be 3
                And the opacity of the points on the scatter plot should be 0.7
                And the title of the plot should be 'New Plot Title'", code = {
    shiny::testServer(
      app = mod_scatter_display_server,
          args = list(rVals = make_changed_rVals_inputs()), expr = {
        
        test_logger(start = "display", msg = "scatterplot[['alt']] = 'Plot object'")
        testthat::expect_equal(
          object = output$scatterplot[["alt"]],
          expected = "Plot object")

        test_logger(end = "display", msg = "scatterplot[['alt']] = 'Plot object'")
        
        test_logger(start = "display", msg = "inputs() creates ggplot2 object")
        
        plot <- scatter_plot(movies,
          x_var = inputs()$x,
          y_var = inputs()$y,
          col_var = inputs()$z,
          alpha_var = inputs()$alpha,
          size_var = inputs()$size) +
        ggplot2::labs(
          title = inputs()$plot_title,
          x = stringr::str_replace_all(
                  tools::toTitleCase(inputs()$x), "_", " "),
          y = stringr::str_replace_all(
                  tools::toTitleCase(inputs()$y), "_", " ")) +
        ggplot2::theme_minimal() +
        ggplot2::theme(legend.position = "bottom")
        testthat::expect_true(ggplot2::is.ggplot(plot))

        test_logger(end = "display",
          msg = "inputs() creates ggplot2 object")

      })
  })
})

