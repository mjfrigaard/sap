# import testthat and shiny's testServer()
box::use(
  testthat[describe, it, expect_equal],
  shiny[testServer]
)

# import inputs module
box::use(
  app / view / display,
  app / view / var_inputs,
  app / view / aes_inputs
)

describe("Feature: Server Acceptance of Reactive Values
  As a Shiny app developer,
  I want to verify that the display server can accept a list of reactive values
  So that I can ensure the interactive elements of the app respond as expected.",
  code = {
  it("Scenario: Confirming the server's handling of reactive input values
    Given a server function display$server for processing reactive inputs
    When I test the server with a list of reactive inputs:
      | input      | value            |
      | x          | critics_score    |
      | y          | imdb_rating      |
      | z          | mpaa_rating      |
      | alpha      | 0.5              |
      | size       | 2                |
      | plot_title | 'Plot Title'     |
    Then the server should correctly receive and process the reactive inputs
    And the inputs received by the server should match the specified values",
    code = {
    # test inputs to display$server
    testServer(
      app = display$server,
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
                plot_title = "plot title"
                )
              )
      ),
      expr = {
        expect_equal(
          # test against input reactive list
          object = inputs(),
          expected = list(
            x = "critics_score",
            y = "imdb_rating",
            z = "mpaa_rating",
            alpha = 0.5,
            size = 2,
            plot_title = "Plot Title"
          )
        )
    })
  })
})