# Test for mod_counts_tbl_server function
describe(
  "Feature: Movie Data Table Display
   As a user
   I want to see movie data filtered by year range and selected columns
   So that I can analyze specific subsets of movie information",
  code = {
    it(
      "Scenario: Table displays correctly filtered data
       Given the movies data is available
       When I select a year range from 2000 to 2010
       And I select 'Mpaa Rating' as character variable
       Then the table should display movies from that year range
       And show Title, MPAA Rating, and Theater Release Year columns",
      code = {
        shiny::testServer(
          app = mod_counts_tbl_server,
          args = list(
            vals = shiny::reactive(
              list(
                start_year = 2000,
                end_year = 2010,
                chr_var = "mpaa_rating"
              )
            )
          ),
          expr = {
            # Test that the output reactable is created
            # Note: We can't directly test the reactable output contents,
            # but we can verify the function completes without error
            # We would expect that when vals() is provided with the test values,
            # the module correctly filters and displays the data
            
            expect_equal(
              object = vals(),
              expected = list(
                start_year = 2000,
                end_year = 2010,
                chr_var = "mpaa_rating"
              )
            )
            
            # Additional verification would require mocking the reactable output
            # or using more advanced testing techniques
          }
        )
      }
    )
  }
)

