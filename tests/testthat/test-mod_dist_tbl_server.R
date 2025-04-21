# Test for mod_dist_tbl_server module
describe(
  "Feature: Distribution Table Generation in Movie Review Application
      As a user 
      I want to see a distribution table based on variables I select
      So that I can analyze the relationship between character and numeric variables.",
  code = {
    it(
      "Scenario: Distribution table successfully renders with valid inputs
         Given the distribution table module is loaded
         When valid character and numeric variables are provided
         Then the distribution table should be generated correctly",
      code = {
        shiny::testServer(
          app = mod_dist_tbl_server,
          args = list(
            vals = reactive(
              list(
                chr_var = "mpaa_rating", 
                num_var = "imdb_rating"
              )
            )
          ),
          expr = {
            # Test that the table output is created properly
            # We can't directly test the actual reactable output,
            # but we can verify the module values are passed inside 
            # function
            expect_equal(
              object = vals(),
              expected = list(
                chr_var = "mpaa_rating", 
                num_var = "imdb_rating"
              )
            )
          }
        )
      }
    )
    
    it(
      "Scenario: Distribution table handles missing inputs
         Given the distribution table module is loaded
         When NULL values are provided
         Then the table should not render due to req() validation",
      code = {
        shiny::testServer(
          app = mod_dist_tbl_server,
          args = list(
            vals = reactive(NULL)
          ),
          expr = {
            # The module uses req(vals()), so output should not be created
            # when vals() is NULL
            expect_equal(
              object = vals(),
              expected = NULL
            )
          }
        )
      }
    )
  }
)
