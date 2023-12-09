# import testthat and ggplot2 function
box::use(
  testthat[...],
  ggplot2[is.ggplot]
)
# import data and plot modules
box::use(
  app / logic / data,
  app / logic / plot
)

# call function to import movies data
movies <- data$movies_data()

# test point plot
expect_true(
  is.ggplot(
      # call scatter_plot() from plot module
      plot$scatter_plot(
        df = movies,
        x_var = 'critics_score', 
        y_var = 'imdb_rating', 
        col_var = 'mpaa_rating', 
        alpha_var = 2 / 3,
        size_var = 2
      )
    )
  )