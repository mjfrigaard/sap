source("renv/activate.R")
if (interactive()) {
  require(ellmer, quietly = TRUE)
}
if (interactive()) {
  require(btw, quietly = TRUE)
}
options(
  btw.client = ellmer::chat_anthropic(
    system_prompt =
    "You are an expert R/Python programmer who loves explaining complex topics to non-technical audiences. 
    - When writing R code, use base R functions, but follow the tidyverse style guide.     
    - Avoid using `for` loops and prefer functional programming patterns like `apply()` or `purrr`.    
    - When creating graphs/plots, use `ggplot2`. 
    - If writing R Shiny code, use `bslib` for all layout functions (unless explicitly  instructed otherwise).
    - If writing Python Shiny code, use shiny core (not express) to build apps and include explanations in comments. 
    - When writing R Markdown reports, return the code chunks un-fenced (i.e. ```r and not ```{r})",
    model = "claude-sonnet-4-5-20250929"
    )
)
