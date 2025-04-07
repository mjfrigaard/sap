## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----eval=FALSE---------------------------------------------------------------
# stream <- chat$stream("What are some common uses of R?")
# coro::loop(for (chunk in stream) {
#   cat(toupper(chunk))
# })
# #>  R IS COMMONLY USED FOR:
# #>
# #>  1. **STATISTICAL ANALYSIS**: PERFORMING COMPLEX STATISTICAL TESTS AND ANALYSES.
# #>  2. **DATA VISUALIZATION**: CREATING GRAPHS, CHARTS, AND PLOTS USING PACKAGES LIKE  GGPLOT2.
# #>  3. **DATA MANIPULATION**: CLEANING AND TRANSFORMING DATA WITH PACKAGES LIKE DPLYR AND TIDYR.
# #>  4. **MACHINE LEARNING**: BUILDING PREDICTIVE MODELS WITH LIBRARIES LIKE CARET AND #>  RANDOMFOREST.
# #>  5. **BIOINFORMATICS**: ANALYZING BIOLOGICAL DATA AND GENOMIC STUDIES.
# #>  6. **ECONOMETRICS**: PERFORMING ECONOMIC DATA ANALYSIS AND MODELING.
# #>  7. **REPORTING**: GENERATING DYNAMIC REPORTS AND DASHBOARDS WITH R MARKDOWN.
# #>  8. **TIME SERIES ANALYSIS**: ANALYZING TEMPORAL DATA AND FORECASTING.
# #>
# #>  THESE USES MAKE R A POWERFUL TOOL FOR DATA SCIENTISTS, STATISTICIANS, AND RESEARCHERS.

## ----eval=FALSE---------------------------------------------------------------
# library(promises)
# 
# chat$chat_async("How's your day going?") %...>% print()
# #> I'm just a computer program, so I don't have feelings, but I'm here to help you with any questions you have.

## ----eval=FALSE---------------------------------------------------------------
# stream <- chat$stream_async("What are some common uses of R?")
# coro::async(function() {
#   for (chunk in await_each(stream)) {
#     cat(toupper(chunk))
#   }
# })()
# #>  R IS COMMONLY USED FOR:
# #>
# #>  1. **STATISTICAL ANALYSIS**: PERFORMING VARIOUS STATISTICAL TESTS AND MODELS.
# #>  2. **DATA VISUALIZATION**: CREATING PLOTS AND GRAPHS TO VISUALIZE DATA.
# #>  3. **DATA MANIPULATION**: CLEANING AND TRANSFORMING DATA WITH PACKAGES LIKE DPLYR.
# #>  4. **MACHINE LEARNING**: BUILDING PREDICTIVE MODELS AND ALGORITHMS.
# #>  5. **BIOINFORMATICS**: ANALYZING BIOLOGICAL DATA, ESPECIALLY IN GENOMICS.
# #>  6. **TIME SERIES ANALYSIS**: ANALYZING TEMPORAL DATA FOR TRENDS AND FORECASTS.
# #>  7. **REPORT GENERATION**: CREATING DYNAMIC REPORTS WITH R MARKDOWN.
# #>  8. **GEOSPATIAL ANALYSIS**: MAPPING AND ANALYZING GEOGRAPHIC DATA.

