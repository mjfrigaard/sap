library(shinytest2)

test_that("{shinytest2} recording: rap", {
  app <- AppDriver$new(name = "rap", height = 916, width = 1267)
  app$set_inputs(`app-vals-y` = "imdb_num_votes")
  app$set_inputs(`app-vals-x` = "critics_score")
  app$set_inputs(`app-vals-z` = "genre")
  app$set_inputs(`app-aes-alpha` = 0.7)
  app$set_inputs(`app-aes-size` = 3)
  app$set_inputs(`app-aes-plot_title` = "new plot title")
  app$expect_values()
})
