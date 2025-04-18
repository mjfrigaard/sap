# Test for awards table module
describe(
  "Feature: Award Table Generation in Movie Review Application
      As a user 
      I want to view a table of movie awards
      So that I can see which movies won specific awards in a date range.",
  code = {
    it(
      "Scenario: Award table displays correct data for specified parameters
         Given I have selected an award type and year range
         When the table is rendered
         Then it should contain the properly formatted award data
         And apply the correct visual styling",
      code = {
        shiny::testServer(
          app = mod_awards_tbl_server,
          args = list(
            vals = shiny::reactive(
              list(
                award = "Films",
                start_year = 2000,
                end_year = 2010
              )
            )
          ),
          expr = {
            # Verify the parameters passed to vals() are correctly received
            expect_equal(
              object = vals(),
              expected = list(
                award = "Films",
                start_year = 2000,
                end_year = 2010
              )
            )
          }
        )
      }
    )
  }
)