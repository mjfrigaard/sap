# Test for mod_awards_vars_server
describe(
  "Feature: Award Criteria Selection in Movie Application
   As a user
   I want to select award criteria and years
   So that I can filter movies based on award nominations and time period",
  code = {
    it(
      "Scenario: Award criteria selection and year range validation
       Given the award selection module is loaded
       When I select 'Oscar' award and years 2000-2010
       Then the module should return the correct values
       And ensure year ranges are valid",
      code = {
        shiny::testServer(
          app = mod_awards_vars_server,
          expr = {
              test_vals <-  list(start_year = 2000,
                                 end_year = 2010,
                                 award = "Films")
            # Set initial inputs
            session$setInputs(
              award = "Films",
              start_year = 2000,
              end_year = 2010
            )
            
            # Test that the returned reactive contains expected values
            expect_equal(
              object = session$returned(),
              expected = test_vals)
            
            # Test year range validation 
            session$setInputs(end_year = 2015)
            # The observe logic should have updated end_year
            expect_equal(input$end_year, 2015)
            
          }
        )
      }
    )
  }
)