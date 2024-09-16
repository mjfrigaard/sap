describe(
  "Feature: Scatter plot data visualization
       As a film data analyst
       I want to explore IMDB.com movie review data
       So that I can view relationships between movie review metrics",
  code = {
    describe(
      "Background:
       Given I have IMDB movie review data
       And the data contains continuous variables like 'rating'
       And the data contains categorical variables like 'mpaa'",
      code = {
        it(
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