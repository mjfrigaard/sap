testthat::describe(
  "Feature: Scatter plot data visualization
       As a film data analyst
       I want to explore movie review data from IMDB.com
       So that I can analyze relationships between movie reivew metrics",
  code = {
    testthat::describe(
      "Background:
       Given I have data with IMDB movie reviews
       And the data contains continuous variables like 'rating'
       And the data contains categorical variables like 'mpaa'",
      code = {
        testthat::it(
          "Scenario: Create scatter plot
             Given I have launched the movie review exploration app,
             When the scatter plot renders,
             Then the points on the x axis should represent 'Ratings'
             And the points on the y axis should represent 'Length'
             And the points should be colored by 'MPAA' rating",
          code = {
            
        })
      })
    })