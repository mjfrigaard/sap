describe(
  "Feature: Scatter Plot Configuration in Movie Review Application
      As a user 
      I want the initial graph pre-configured with variables and aesthetics,
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
         And the opacity of the points should be set to '0.5'
         And the plot title should be 'New Plot Title'",
      code = {
        shiny::testServer(
          app = mod_scatter_display_server,
          args = list(
            var_inputs =
              reactive(
                list( 
                    x = "critics_score",
                    y = "imdb_rating",
                    z = "mpaa_rating"
                  )
                ),
              aes_inputs =
                reactive(
                  list( 
                    alpha = 0.5,
                    size = 2,
                    plot_title = "new plot title"
                    )
                  )
          ),
          expr = {
            
            test_logger(start = "COLLECT", msg = "collected module values")
            
            expect_equal(
              object = inputs(),
              expected = list(
                x = "critics_score",
                y = "imdb_rating",
                z = "mpaa_rating",
                alpha = 0.5,
                size = 2,
                plot_title = "New Plot Title"
              )
            )
            
            test_logger(end = "COLLECT", msg = "collected module values")

            test_logger(start = "OUTPUT", msg = "is list")
            expect_true(
              object = is.list(output$scatterplot))
            test_logger(end = "OUTPUT", msg = "is list")
            
            test_logger(start = "OUTPUT", msg = "names")
            expect_equal(
              object = names(output$scatterplot),
              expected = c("src", "width", "height", "alt", "coordmap"))
            test_logger(end = "OUTPUT", msg = "names")
            
            test_logger(start = "OUTPUT", msg = "Plot object")
            expect_equal(
              object = output$scatterplot[["alt"]],
              expected = "Plot object")
            test_logger(end = "OUTPUT", msg = "Plot object")
            
            test_logger(start = "OUTPUT", msg = "is ggplot")
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
            test_logger(end = "OUTPUT", msg = "is ggplot")
            
            print(plot)
            
          })
      })
  })