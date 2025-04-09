# import testthat and shiny's testServer()
box::use(
  testthat[describe, it, expect_equal],
  shiny[testServer]
)

# import inputs module
box::use(
  app / view / var_inputs
)

describe("Feature: Server Reactive Values Verification
  As a Shiny app developer,
  I want to ensure the var_inputs module returns a list of reactive values 
  So that I can confirm the server's responsiveness to input changes.", 
  code = {
  it("Scenario: Checking the return values of the server function
    Given a server function inputs$server for handling reactive inputs
    When I create a server object and set reactive input values as:
      | input       | value            |
      | x           | audience_score   |
      | y           | imdb_rating      |
      | z           | mpaa_rating      |
    And I compare the returned values from the server
    Then the returned values should match the following list:
      | key        | value            |
      | x          | audience_score   |
      | y          | imdb_rating      |
      | z          | mpaa_rating      |", 
    code = {
    # create server object
    testServer(app = var_inputs$server, expr = {
      # create list of output vals
      test_vals <- list(
        x = "audience_score",
        y = "imdb_rating",
        z = "mpaa_rating")
      # change inputs
      session$setInputs(x = "audience_score",
                        y = "imdb_rating",
                        z = "mpaa_rating")
      # test class
      expect_equal(
        object = session$returned(),
        expected = test_vals
      )
   })
  })
})