test_that("Scenario: Changing scatter plot size, alpha, and title values
             Given the movie review application is loaded
             When I choose the 3.5 for the size
             And I choose the 0.5 for the alpha
             And I choose the [new title] for title
             Then the scatter plot should show 3.5 on the size
             And the scatter plot should show 0.5 on the alpha
             And the title on the scatter plot should be 'new title'",
  code = {
    shiny::testServer(app = mod_aes_inputs_server, expr = {
      test_vals <- list(
        alpha = 0.5,
        size = 3.5,
        plot_title = "new title"
      )

      test_logger(start = "RETURNED", msg = "test_vals vs. session$returned()")

      session$setInputs(
        alpha = 0.5,
        size = 3.5,
        plot_title = "new title"
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
