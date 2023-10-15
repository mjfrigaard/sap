testthat::describe( 
  "US1: Shiny App Scatter Plot Data Visualization for
   Movie Review Explorer", code = { 
  
  testthat::describe(
    "F1.1: IMDB and Rotten Tomatoes data with continuous
    (i.e., scores) and categorical (i.e., mpaa) variables", 
    code = { 
      
    testthat::it( 
    "Test 1
      
     Scenario: IMDB/Rotten Tomatoes data source
        When I launched the scatter plot data visualization app
        Then a column with links to the original source URLs for
          both IMDB and Rotten Tomatoes should be verified.", 
        code = { 
          
        }) 
      
    }) 
  
}) 