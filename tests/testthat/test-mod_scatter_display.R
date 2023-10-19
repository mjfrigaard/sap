testthat::describe("F1.2: user-input updating", code = {
  testthat::it(description = "
    Scenario: Select x, y, color values for plotting
      When I launched the Scatter Plot Data Visualization
      And I select the variable 'Critics Score' for the x-axis
      And I select the variable 'Runtime' for the y-axis
      And I select the variable 'Title Type' for the color 
      Then the scatter plot should show 'Critics Score' on the x-axis
      And the scatter plot should show 'Runtime' on the y-axis
      And the points on the scatter plot should be colored by 'Title Type'", code = {
    shiny::testServer(
      app = mod_scatter_display_server,
      args = list(var_inputs = 
          shiny::reactive(list(
                     x = "critics_score",
                     y = "runtime",
                     z = "title_type",
                     alpha = 0.5,
                     size = 2,
                     plot_title = "Enter Plot Title"))),
      expr = {
        test_logger(start = "T6", msg = "F1.2: inputs()")
        testthat::expect_equal(
          object = inputs(),
          expected = list(x = "critics_score",
                          y = "runtime",
                          z = "title_type",
                          alpha = 0.5,
                          size = 2,
                          plot_title = "Enter Plot Title")
        )
        test_logger(end = "T6", msg = "F1.2: inputs()")
      })
        
  testthat::it(description = "
    Scenario: Select x, y, color values for plotting
      When I launched the Scatter Plot Data Visualization
      And I select the variable 'IMDB Rating' for the x-axis
      And I select the variable 'Audience Score' for the y-axis
      And I select the variable 'MPAA Raing' for the color 
      Then the scatter plot should show 'IMDB Rating' on the x-axis
      And the scatter plot should show 'Audience Score' on the y-axis
      And the points on the scatter plot should be colored by 'MPAA Raing'", code = {
    shiny::testServer(
      app = mod_scatter_display_server,
      args = list(var_inputs = 
          shiny::reactive(list(
                    x = "imdb_rating",
                    y = "audience_score",
                    z = "mpaa_rating",
                    alpha = 0.5,
                    size = 2,
                    plot_title = "Enter plot title"))),
      expr = {
        
        test_logger(start = "T6a", msg = "FR2: is.list()")
        
        testthat::expect_true(
          object = is.list(output$scatterplot))
        test_logger(end = "T6a", msg = "FR2: is.list()")

        test_logger(start = "T6b", msg = "FR2: names()")
        testthat::expect_equal(
          object = names(output$scatterplot),
          expected = c("src", "width", "height", "alt", "coordmap"))
        test_logger(end = "T6b", msg = "FR2: names()")

        test_logger(start = "T6c", msg = "FR2: alt:'Plot object'")
        testthat::expect_equal(
          object = output$scatterplot[["alt"]],
          expected = "Plot object")
        test_logger(end = "T6c", msg = "FR2: alt:'Plot object'")
        
        test_logger(start = "T6d", msg = "FR2: is.ggplot()")
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
        
        test_logger(end = "T6d", msg = "FR2: is.ggplot()")
        
        print(plot)
        
      })
      })
  })
})

