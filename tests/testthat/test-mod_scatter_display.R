testthat::describe(
  "Feature 1.2: Scatter Plot Configuration in Movie Review Application
    As a user who accesses the movie review application,
    I want the initial scatter plot pre-configured with variables and aesthetics,
    So that I can immediately see a meaningful visualization.",
  code = {
    testthat::it(
      "Then the scatter plot should show 'IMDB Rating' on the x-axis
       And the scatter plot should show 'Audience Score' on the y-axis
       And the points on the scatter plot should be colored by 'MPAA Rating'",
      code = {
        shiny::testServer(
          app = mod_scatter_display_server,
          args = list(
            var_inputs =
              # shiny::reactive(
                list(
                    x = "imdb_rating",
                    y = "audience_score",
                    z = "mpaa_rating",
                    alpha = 0.5,
                    size = 2,
                    plot_title = "Enter Plot Title"
                  )
                # )
          ),
          expr = {
            test_logger(start = "T6", msg = "initial values")
            testthat::expect_equal(
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
            test_logger(end = "T5", msg = "initial values")
          })
      })
  })


testthat::describe(
  "Feature F1.3: Scatter plot data visualization (outputs rendering)
     As a film data analyst
     I want to explore continuous and categorical variables in the movie review data
     So that I can analyze relationships between movie reivew metrics

  Scenario: Change x, y, color values for plotting
          When I launched the Scatter Plot Data Visualization
          And I choose the variable 'IMDB number of votes' for the x-axis
          And I choose the variable 'Critics Score' for the y-axis
          And I choose the variable 'Genre' for the color", code = {
  testthat::it(
      "Then the scatter plot should show 'IMDB number of votes' on the x-axis
       And the scatter plot should show 'Critics Score' on the y-axis
       And the points on the scatter plot should be colored by 'Genre'",
    code = {
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

        # test_logger(start = "T5", msg = "F1.3: user-input updating")
        # testthat::expect_equal(
        #   object = inputs(),
        #   expected = list(x = "critics_score",
        #                y = "imdb_num_votes",
        #                z = "genre",
        #                alpha = 0.75,
        #                size = 3,
        #                plot_title = "New Plot Title"
        #             )
        #   )
        # test_logger(end = "T5", msg = "user-input updating")

        # test_logger(start = "T6a", msg = "F1.3: is.list()")
        # testthat::expect_true(
        #   object = is.list(output$scatterplot))
        # test_logger(end = "T6a", msg = "F1.3: is.list()")

        # test_logger(start = "T6b", msg = "F1.3: names()")
        # testthat::expect_equal(
        #   object = names(output$scatterplot),
        #   expected = c("src", "width", "height", "alt", "coordmap"))
        # test_logger(end = "T6b", msg = "F1.3: names()")

        test_logger(start = "T6c", msg = "F1.3: alt:'Plot object'")
        testthat::expect_equal(
          object = output$scatterplot[["alt"]],
          expected = "Plot object")
        test_logger(end = "T6c", msg = "F1.3: alt:'Plot object'")

        test_logger(start = "T6d", msg = "user-input is.ggplot()")
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
        test_logger(end = "T6d", msg = "user-input is.ggplot()")

        print(plot)

      })
  })
})

