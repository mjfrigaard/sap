describe("Scenario: Scatter plot initial x, y, color values
         Given the movie review application is loaded
         When I view the initial scatter plot", code = {
  it(
  "Then the scatter plot should show 'IMDB Rating' on the x-axis
   And the scatter plot should show 'Audience Score' on the y-axis
   And the points on the scatter plot should be colored by 'MPAA Rating'
   And the size of the points should be set to '2'
   And the opacity of the points should be set to '0.5'
   And the plot title should be 'Enter plot title'",
  code = {
    testServer(
      app = plot_display_server,
      args = list(var_inputs =
          shiny::reactive(
            list(
              x = "imdb_rating",
              y = "audience_score",
              z = "mpaa_rating",
              alpha = 0.5,
              size = 2,
              plot_title = "Enter Plot Title"
            )
          )),
      expr = {
        expect_equal(
          object = inputs(),
          expected = list(
            x = "imdb_rating",
            y = "audience_score",
            z = "mpaa_rating",
            alpha = 0.5,
            size = 2,
            plot_title = "Enter Plot Title"
          )
        )
    })
  })
})

