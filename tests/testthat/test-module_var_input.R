describe("Scenario: Changing scatter plot x, y, color values
          Given the movie review application is loaded
          When I choose the [Critics Score] variable for the x-axis
          And I choose the [Runtime] variable for the y-axis
          And I choose the [Title type] variable for color", code = {
  it("Then the scatter plot should show [Critics score] on the x-axis
       And the scatter plot should show [Runtime] on the y-axis
       And the points on the scatter plot should be colored by [Title type]
       And the opacity of the points should be set to [0.5]
       And the size of the points should be set to [2]
       And the plot title should be [Enter plot title]", code = {
      testServer(app = var_input_server, expr = {
          # set inputs
          session$setInputs(y = "imdb_rating",
                            x = "audience_score",
                            z = "mpaa_rating",
                            alpha = 0.5,
                            size = 2,
                            plot_title = "Enter plot title")
          testthat::expect_equal(object = session$returned(),
            expected = list(y = "imdb_rating",
                            x = "audience_score",
                            z = "mpaa_rating",
                            alpha = 0.5,
                            size = 2,
                            plot_title = "Enter plot title"))
          # flush reactives
          session$flushReact()
          # set inputs
          session$setInputs(y = "critics_score",
                            x = "runtime",
                            z = "title_type",
                            alpha = 0.5,
                            size = 2,
                            plot_title = "Enter plot title")

          testthat::expect_equal(object = session$returned(),
            expected = list(y = "critics_score",
                            x = "runtime",
                            z = "title_type",
                            alpha = 0.5,
                            size = 2,
                            plot_title = "Enter plot title"))
        })
     })
})

