library(shinytest2)
test_that("app process starts and stops", {
  app <- AppDriver$new(launch_app, name = "process")
  proc <- app$get_process()
  expect_true(proc$is_alive())
  app$stop()
  expect_false(proc$is_alive())
})
