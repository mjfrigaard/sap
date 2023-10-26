library(shinytest2)

test_that("{shinytest2} recording: feature-01", {
  app <- AppDriver$new(name = "feature-01", height = 800, width = 1173)
  app$set_inputs(`vars-y` = "imdb_num_votes")
  app$set_inputs(`vars-x` = "critics_score")
  app$set_inputs(`vars-z` = "genre")
  app$set_inputs(`vars-alpha` = 0.7)
  app$set_inputs(`vars-size` = 3)
  app$set_inputs(`vars-plot_title` = "New plot title")
  app$expect_values()
})
