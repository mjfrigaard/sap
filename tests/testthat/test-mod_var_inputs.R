test_that("Scenario: Changing scatter plot x, y, and color values
             Given the movie review application is loaded
             When I choose the [Critics Score] for the x-axis
             And I choose the [Runtime] for the y-axis
             And I choose the [Title type] for color
             Then the scatter plot should show [Critics score] on the x-axis
             And the scatter plot should show [Runtime] on the y-axis
             And the points on the scatter plot should be colored by [Title type]",
  code = {
    shiny::testServer(app = mod_var_inputs_server, expr = {
      test_vals <- list(
        y = "runtime",
        x = "critics_score",
        z = "title_type"
      )

      test_logger(start = "RETURNED", msg = "test_vals vs. session$returned()")

      session$setInputs(
        y = "runtime",
        x = "critics_score",
        z = "title_type"
      )

      expect_equal(
        object = session$returned(),
        expected = test_vals
      )

      test_logger(end = "RETURNED", msg = "test_vals vs. session$returned()")

      session$flushReact()
    })
  }
)
