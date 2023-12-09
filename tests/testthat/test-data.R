# import testthat 
box::use(
  testthat[...]
)
# import data module
box::use(
  app / logic / data
)
test_that(desc = "movies dimensions", code = {
  # call function to import movies data
  movies <- data$movies_data()
  # test dimensions
  expect_equal(
    object = dim(movies), 
    expected = c(651L, 34L))
  # test class
  expect_true(object = is.data.frame(movies))
})

test_that(desc = "test numeric variables", code = {
  # call function to import movies data
  movies <- data$movies_data()
  num_vars <- c("imdb_rating", "imdb_num_votes", 
                "critics_score", "audience_score", 
                "runtime")
  expect_true(object = all(num_vars %in% names(movies)))
})

test_that(desc = "test color variables", code = {
  # call function to import movies data
  movies <- data$movies_data()
  color_vars <- c("title_type", "genre", 
                  "mpaa_rating", "critics_rating", 
                  "audience_rating")
  expect_true(object = all(color_vars %in% names(movies)))
})