library(chromote)
library(shinytest2)
test_that("{shinytest2} recording: leprechaun app", {
  app <- AppDriver$new(name = "lap-01", height = 800, width = 1173)
  app$set_inputs(`vars-y` = "imdb_num_votes")
  app$set_inputs(`vars-x` = "critics_score")
  app$set_inputs(`vars-z` = "genre")
  app$set_inputs(`aes-alpha` = 0.7)
  app$set_inputs(`aes-size` = 3)
  app$set_inputs(`aes-plot_title` = "New plot title")
  app$expect_values()
})

