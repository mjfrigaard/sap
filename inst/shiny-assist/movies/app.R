# Load required libraries
library(shiny)
library(ggplot2)
library(dplyr)
library(readr)
library(bslib)
library(thematic)

# Setup thematic to automatically adjust plot theme to match app theme
thematic_shiny(font = "auto")

# Run the application 
movie_visualization_app()
