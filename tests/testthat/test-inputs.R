# import testthat and shiny::testServer()
box::use(
  testthat[...],
  shiny[testServer]
)

# import inputs module
box::use(
  app / view / inputs
)
describe("confirm UI returns a shiny.tag.list/list", code = {
  it("ui object", code = {
    # create ui object
    ui <- inputs$ui(id = "x")
    # test class
    expect_equal(object = class(ui), 
      expected = c("shiny.tag.list", "list"))
  })
})

describe("confirm UI returns list of reactive values", code = {
  it("server return values", code = {
    # create server object
    testServer(app = inputs$server, expr = {
      # create list of output vals
      test_vals <- list(
        x = "audience_score",
        y = "imdb_rating",
        z = "mpaa_rating",
        alpha = 0.75,
        size = 3,
        plot_title = "Example title")
      # change inputs
      session$setInputs(x = "audience_score",
                        y = "imdb_rating",
                        z = "mpaa_rating",
                        alpha = 0.75,
                        size = 3,
                        plot_title = "Example title")
      # test class
      expect_equal(
        object = session$returned(),
        expected = test_vals
      )
   })
  })
})