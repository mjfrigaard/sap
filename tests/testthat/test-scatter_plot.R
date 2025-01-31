test_that("scatter_plot creates a ggplot object", {
  p <- scatter_plot(mtcars, "mpg", "hp", "cyl", 0.7, 3)
  # expect_s3_class(p, "gg") # not needed if using below
  expect_true(ggplot2::is.ggplot(p))
  # expect_equal(ggplot2::ggplot_build(p)$layout$panel_ranges[[1]]$x.range,
  #   range(mtcars$mpg))
  # expect_equal(ggplot2::ggplot_build(p)$layout$panel_ranges[[1]]$y.range,
  #   range(mtcars$hp))
})

# waldo::compare(
#   x = ggplot2::ggplot_build(p)$layout$panel_params[[1]]$x.range,
#   y = range(mtcars$mpg))
#
# waldo::compare(
#   x = ggplot2::ggplot_build(p)$layout$panel_params[[1]]$y.range,
#   y = range(mtcars$hp))

test_that("scatter_plot handles different alpha and size values", {
  p1 <- scatter_plot(mtcars, "mpg", "hp", "cyl", 0.5, 2)
  p2 <- scatter_plot(mtcars, "mpg", "hp", "cyl", 1, 4)
  expect_true(p1$layers[[1]]$aes_params$alpha < p2$layers[[1]]$aes_params$alpha)
  expect_true(p1$layers[[1]]$aes_params$size < p2$layers[[1]]$aes_params$size)
})
