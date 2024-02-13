describe("Feature: Checking if an R package is installed", {
  
  test_that(
    "Scenario: Checking an uninstalled package
        Given the R package 'foo' is not installed
        When I call the `check_installed()` function with 'foo'
        Then the function should raise an error with the message
        `Please install 'nonexistent_package' before continuing`", {
          
    test_logger(start = "mock is_installed", msg = "FALSE")
    local_mocked_bindings(is_installed = function(package) FALSE)
    expect_error(object = check_installed("foo"))
    test_logger(end = "mock is_installed", msg = "FALSE")
    
  })
  
})

describe("Feature: Checking if an R package is installed", {
  
  test_that(
    "Scenario: Checking an installed package
        Given the R package 'base' is installed
        When I call the `check_installed()` function with 'base'
        Then the function should return without any error", {
          
    test_logger(start = "mock is_installed", msg = "TRUE")
    local_mocked_bindings(is_installed = function(package) TRUE)
    expect_invisible(check_installed("base"))
    test_logger(end = "mock is_installed", msg = "TRUE")
    
  })
})