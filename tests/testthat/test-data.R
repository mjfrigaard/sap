# import testthat 
box::use(
  testthat[describe, it, expect_equal, expect_true]
)

# import data module
box::use(
  app / logic / data
)

describe(description = "Feature: Movies Data Dimensions Verification
  As a data analyst,
  I want to ensure the movies data frame has the correct dimensions
  So that I can rely on its structure for further analysis.", 
  code = {
  it(description = "Scenario: Checking the dimensions of the movies data frame
    Given a function to import movies data
    When I call the function to retrieve the movies data
    Then the data frame should have 651 rows and 34 columns
    And the data frame should be of type 'data.frame'", 
    code = {
    # call function to import movies data
    movies <- data$movies_data()
    # test dimensions
    expect_equal(
      object = dim(movies), 
      expected = c(651L, 34L))
    # test class
    expect_true(object = is.data.frame(movies))
  })
})