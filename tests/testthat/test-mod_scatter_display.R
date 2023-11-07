describe(
  "Feature: Scatter Plot Configuration in Movie Review Application
    As a user who accesses the movie review application,
    I want the initial scatter plot pre-configured with variables and aesthetics,
    So that I can immediately see a meaningful visualization.",
  code = {
    it(
      "Scenario: Scatter plot initial x, y, color values 
         Given the movie review application is loaded
         When I view the initial scatter plot
         Then the scatter plot should show 'IMDB Rating' on the x-axis
         And the scatter plot should show 'Audience Score' on the y-axis
         And the points on the scatter plot should be colored by 'MPAA Rating'
         And the size of the points should be set to '2'
         And the opacity of the points should be set to '0.5'",
      code = {
        shiny::testServer(app = mod_scatter_display_server,
          args = list(var_inputs =
              shiny::reactive(
                list(
                    x = "imdb_rating",
                    y = "audience_score",
                    z = "mpaa_rating",
                    alpha = 0.5,
                    size = 2,
                    plot_title = "Enter Plot Title"
                  )
                )
          ),
          expr = {
            
            test_logger(
              start = "display", 
              msg = "selected_vars initial values")
            
            expect_equal(
              object = inputs(),
              expected = list(
                    x = "imdb_rating",
                    y = "audience_score",
                    z = "mpaa_rating",
                    alpha = 0.5,
                    size = 2,
                    plot_title = "Enter Plot Title"
                )
            )
            test_logger(end = "display", 
              msg = "selected_vars initial values")
          })
      })
  })


describe(
  "Feature: Scatter plot data visualization (outputs rendering)
     As a film data analyst
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
  it("Then the scatter plot should show 'IMDB number of votes' on the x-axis
                And the scatter plot should show 'Critics Score' on the y-axis
                And the points on the scatter plot should be colored by 'Genre'
                And the size of the points on the scatter plot should be 3
                And the opacity of the points on the scatter plot should be 0.7
                And the title of the plot should be 'New Plot Title'", code = {
    shiny::testServer(
      app = mod_scatter_display_server,
      args = list(var_inputs =
          shiny::reactive(
                  list(x = "critics_score",
                       y = "imdb_num_votes",
                       z = "genre",
                       alpha = 0.75,
                       size = 3,
                       plot_title = "New plot title"
                    )
            )), expr = {

        test_logger(
          start = "display", 
          msg = "scatterplot[['alt']] = 'Plot object'")
              
        expect_equal(
          object = output$scatterplot[["alt"]],
          expected = "Plot object")
        
        test_logger(end = "display", 
          msg = "scatterplot[['alt']] = 'Plot object'")

        test_logger(start = "display", 
          msg = "inputs() creates ggplot2 object")
        
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
        expect_true(ggplot2::is.ggplot(plot))
        
        test_logger(end = "display", 
          msg = "inputs() creates ggplot2 object")

      })
  })
})
