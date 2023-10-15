testthat::describe("FR2: user-input updating (inputs)", code = {
  
  testthat::it("T5: inputs change", code = {
    shiny::testServer(app = mod_var_input_server, expr = {
      
      test_logger(start = "T5", msg = "FR2: returned()")
      
      # create list of output vals
      test_vals <- list(y = "critics_score",
                        x = "imdb_rating",
                        z = "critics_rating",
                        alpha = 0.75,
                        size = 3,
                        plot_title = "Example title")

      # change inputs
      session$setInputs(y = "critics_score",
                        x = "imdb_rating",
                        z = "critics_rating",
                        alpha = 0.75,
                        size = 3,
                        plot_title = "Example title")

      testthat::expect_equal(
        object = session$returned(),
        expected = test_vals
      )

      test_logger(end = "T5", msg = "FR2: returned()")
      
    })
  })
})