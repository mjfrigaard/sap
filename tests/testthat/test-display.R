# import testthat and shiny::testServer()
box::use(
  testthat[...],
  shiny[testServer, reactive]
)

# import inputs and display modules
box::use(
  app / view / inputs,
  app / view / display
)

describe("confirm UI returns a shiny.tag.list/list", code = {
  it("ui object", code = {
  # create ui object
  ui <- display$ui(id = "y")
  # test class
  expect_equal(object = class(ui), 
    expected = c("shiny.tag.list", "list"))
  })
})

describe("confirm server accepts list of reactive values", code = {
  it("server input values", code = {
    # test inputs to display$server
    testServer(
      app = display$server,
      args = list(
        # include list of reactive inputs
        var_inputs =
          reactive(
            list(
                 x = "critics_score",
                 y = "imdb_rating",
                 z = "mpaa_rating",
                 alpha = 0.5,
                 size = 2,
                 plot_title = "Enter Plot Title"
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
            plot_title = "Enter Plot Title"
          )
        )
    })
  })
})

describe("confirm server output is expected object from plotOutput()", code = {
  it("test output from display$server", code = {
    testServer(
      app = display$server,
      args = list(
        # include list of reactives 
        var_inputs =
          reactive(
            list(
                 x = "critics_score",
                 y = "imdb_rating",
                 z = "mpaa_rating",
                 alpha = 0.5,
                 size = 2,
                 plot_title = "Enter Plot Title"
                )
            )
      ), 
      expr = {
        # test is list
      expect_true(
        object = is.list(output$scatterplot))
        # test for names in output$scatterplot
      expect_equal(
        object = names(output$scatterplot),
        expected = c("src", "width", "height", "alt", "coordmap"))
        # test for 'alt'
      expect_equal(
        object = output$scatterplot[["alt"]],
        expected = "Plot object")
    })
  })
})