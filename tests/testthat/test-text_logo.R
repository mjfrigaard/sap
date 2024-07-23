describe(
    "Scenario: Generating a logo with default size
    Given the user did not specify a [size] in text_logo()
    When text_logo() is invoked without a [size] argument
    Then the correct HTML for a ['h3'] text logo is returned",
  code = {

  test_that("text_logo()", code = {
    test_logger(start = "snap", msg = "text_logo()")
    expect_snapshot(text_logo())
    test_logger(end = "snap", msg = "text_logo()")
  })
})

describe(
    "Scenario: Generating a logo of a specified size
    Given the user wants a ['h1'] sized text logo
    When text_logo(size = 'h1') is invoked 
    Then the correct HTML for a ['h1'] text logo is returned", 
  code = {

  test_that("text_logo('h1')", code = {
    test_logger(start = "snap", msg = "text_logo('})')")
    expect_snapshot(text_logo("h1"))
    test_logger(start = "snap", msg = "text_logo('h1')")
  })  
})

describe(
  "Scenario: Attempting to generate a logo with an invalid size
  Given the user specifies an invalid [size] for the text logo
  When text_logo() is invoked with an invalid [size] argument
  Then an error is returned stating the [size] is not recognized", 
code = {
test_that("text_logo('invalid')", code = {
  test_logger(start = "snap", msg = "text_logo('invalid')")
  expect_error(text_logo("massive"), NULL)
  test_logger(end = "snap", msg = "text_logo('invalid')")
  })
})