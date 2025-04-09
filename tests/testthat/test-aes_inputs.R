# import testthat and shiny's testServer()
box::use(
  testthat[describe, it, expect_equal],
  shiny[testServer]
)

# import inputs module
box::use(
  app / view / aes_inputs
)

describe("Feature: Server Reactive Values Verification
  As a Shiny app developer,
  I want to ensure the aes_inputs module returns a list of reactive values 
  So that I can confirm the server's responsiveness to input changes.", 
  code = {
  it("Scenario: Checking the return values of the server function
    Given a server function aes_inputs$server for handling reactive inputs
    When I create a server object and set reactive input values as:
      | alpha      | 0.5              |
      | size       | 2                |
      | plot_title | Enter Plot Title |
    And I compare the returned values from the server
    Then the returned values should match the following list:
      | alpha      | 0.5              |
      | size       | 2                |
      | plot_title | Enter Plot Title |", 
    code = {
    # create server object
    testServer(app = aes_inputs$server, expr = {
      # create list of output vals
      test_vals <- list(
        alpha = 0.5,
        size = 2,
        plot_title = "Enter Plot Title")
      # change inputs
      session$setInputs(alpha = 0.5,
                        size = 2,
                        plot_title = "Enter Plot Title")
      # test class
      expect_equal(
        object = session$returned(),
        expected = test_vals
      )
   })
  })
})