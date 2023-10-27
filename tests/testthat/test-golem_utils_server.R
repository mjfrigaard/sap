testthat::test_that("not_in works", {
  expect_true(1 %not_in% 2:10)
  expect_false(1 %not_in% 1:10)
})

testthat::test_that("not_null works", {
  expect_true(not_null(1))
  expect_false(not_null(NULL))
})

testthat::test_that("not_na works", {
  expect_true(not_na(1))
  expect_false(not_na(NA))
})

testthat::test_that("drop_nulls works", {
  expect_equal(
    drop_nulls(
      list(x = NULL, y = 2)
    ),
    list(y = 2)
  )
})

testthat::test_that("%||% works", {
  testthat::expect_equal(NULL %||% 1, 1)
  testthat::expect_equal(2 %||% 1, 2)
})

testthat::test_that("%|NA|% works", {
  testthat::expect_equal(
    NA %|NA|% 1, 1)
  testthat::expect_equal(
    2 %|NA|% 1,2)
})

testthat::test_that("rv and rvtl work", {
  testthat::expect_true(inherits(rv, "function"))
  testthat::expect_true(inherits(rvtl, "function"))
})
