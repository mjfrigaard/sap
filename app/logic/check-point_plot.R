# contents for app/logic/check-point_plot.R

# load modules from logic folder
box::use(
  app/logic/data,
  app/logic/plot
)

# import movies data
movies <- data$movies_data()

# check point plot
plot$point_plot(
  df = movies,
  x_var = 'critics_score', # as string
  y_var = 'imdb_rating', # as string
  col_var = 'mpaa_rating', # as string
  alpha_var = 2 / 3,
  size_var = 2
)
