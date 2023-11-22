box::use(
  shiny[testServer],
  testthat[...],
)
box::use(
  app/main[...],
)

# test_that("main server works", {
#     shiny::testServer(inputs$server, expr = {
#       
#       # create list of output vals
#       test_vals <- list(y = "imdb_rating",
#                         x = "audience_score",
#                         z = "mpaa_rating",
#                         alpha = 0.75,
#                         size = 3,
#                         plot_title = "Example title")
# 
#       # change inputs
#       session$setInputs(y = "imdb_rating",
#                         x = "audience_score",
#                         z = "mpaa_rating",
#                         alpha = 0.75,
#                         size = 3,
#                         plot_title = "Example title")
# 
#       testthat::expect_equal(
#         object = session$returned(),
#         expected = test_vals
#       )
#   })
# })
