# Specifications

``` r

suppressPackageStartupMessages(library(sap))
```

This vignette provides example specifications for the `sap` application
(written in the [Gherkin](https://cucumber.io/docs/gherkin/) syntax)

## Movies App Specifications

**Example:** The application should source movie review data from
platforms like IMDB or Rotten Tomatoes

### Features

**Feature:** Movie Review Dataset Variables

***As a*** user

***I want to*** have a dataset with variables from IMDB and Rotten
Tomatoes

***In order to*** provide comprehensive movie reviews

### Background

***Given*** the application has access to data from the IMDB and Rotten
Tomatoes APIs

## Functional Requirements (i.e., Scenarios)

**Scenario**: Movie Review Continuous and Categorical Variables

***When*** the application loads from IMDB and Rotten Tomatoes movie
review data

***Then*** the dataset should include a continuous critic ratings
variable

***And*** the dataset should include a continuous audience ratings
variable

***And*** the dataset should include a categorical mpaa ratings variable

***And*** the dataset should include a categorical genres variable

## Traceability matrix

[TABLE]
