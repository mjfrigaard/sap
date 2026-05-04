# Code Review Session - April 29, 2026

## Overview

Comprehensive code review of the `sap` Shiny app-package conducted using the btw code_reviewer agent.

## 🔴 Critical Issues

### 1. Package Loading in Launch Function (R/launch_app.R)

**Issue:** Loading packages with `library()` inside a function is a major anti-pattern for R packages.

**Current problematic code:**
```r
launch_app <- function(...) {
  library(shiny)
  library(bslib)
  library(ggplot2)
  library(reactable)
  library(rmarkdown)
  # ...
}
```

**Fix:** Remove all `library()` calls and use proper namespace imports:

```r
launch_app <- function(...) {
    # Create and run the app
    shiny::shinyApp(
        ui = app_ui(),
        server = app_server,
        ...
    )
}
```

### 2. Missing Package Self-Reference (app.R)

**Issue:** The deployment script doesn't load the package itself.

**Current:**
```r
# Load the application

# Launch the app
launch_app()
```

**Fix:**
```r
# Load the package
library(sap)

# Launch the app
launch_app()
```

### 3. Hardcoded Package Reference (R/mod_download_report.R)

**Issue:** Line 39 has a hardcoded package reference that will fail:

**Current:**
```r
rmd_path <- system.file("rmd", "report.Rmd", package = ".")
```

**Fix:**
```r
rmd_path <- system.file("rmd", "report.Rmd", package = "sap")
```

## 🟡 Style Guide Violations (grkstyle)

### 1. Function Argument Indentation

**R/mod_visualization.R, lines 27-28:**
```r
# ❌ Current:
req(data(), inputs$x_var(), inputs$y_var(), inputs$col_var(),
    inputs$alpha_var(), inputs$size_var())

# ✅ grkstyle:
req(
    data(),
    inputs$x_var(),
    inputs$y_var(),
    inputs$col_var(),
    inputs$alpha_var(),
    inputs$size_var()
)
```

**R/scatter_plot.R, lines 12-15:**
```r
# ❌ Current:
ggplot2::ggplot(data = df,
  ggplot2::aes(x = .data[[x_var]],
    y = .data[[y_var]],
    color = .data[[col_var]])) +

# ✅ grkstyle:
ggplot2::ggplot(
    data = df,
    ggplot2::aes(
        x = .data[[x_var]],
        y = .data[[y_var]],
        color = .data[[col_var]]
    )
) +
```

**R/mod_download_report.R, lines 62-73:**
```r
# ❌ Current:
rmarkdown::render(
  input = temp_rmd,
  output_file = temp_html,
  output_format = rmarkdown::html_document(
    theme = "flatly",
    toc = TRUE,
    toc_float = TRUE
  ),
  params = params,
  envir = new.env(parent = globalenv()),
  quiet = TRUE
)

# ✅ grkstyle:
rmarkdown::render(
    input = temp_rmd,
    output_file = temp_html,
    output_format = rmarkdown::html_document(
        theme = "flatly",
        toc = TRUE,
        toc_float = TRUE
    ),
    params = params,
    envir = new.env(parent = globalenv()),
    quiet = TRUE
)
```

### 2. Vector Indentation

**R/mod_inputs.R, lines 8-14 and others:**
```r
# ❌ Current:
numeric_choices <- c(
  "runtime",
  "imdb_rating",
  "imdb_num_votes",
  "critics_score",
  "audience_score"
)

# ✅ grkstyle:
numeric_choices <- c(
    "runtime",
    "imdb_rating", 
    "imdb_num_votes",
    "critics_score",
    "audience_score"
)
```

## 🟠 Performance & Reactive Programming Issues

### 1. Inefficient Data Filtering

**Issue:** Data filtering is duplicated across modules using base R subsetting.

**R/mod_visualization.R, lines 31-33:**
```r
# ❌ Current inefficient filtering:
if (!is.null(inputs$genre_filter()) && inputs$genre_filter() != "All") {
  df <- df[df$genre == inputs$genre_filter(), ]
}
```

**Fix:** Create a centralized filtered data reactive in app_server.R:
```r
# In app_server.R:
filtered_data <- reactive({
    data <- movies_data()
    filter_genre <- inputs$genre_filter()
    
    if (!is.null(filter_genre) && filter_genre != "All") {
        data <- data[data$genre == filter_genre, ]
    }
    
    data
})

# Pass filtered_data to modules instead of raw movies_data
```

### 2. Unnecessary Reactive Dependencies

**Issue:** The visualization module recreates the plot unnecessarily when unrelated inputs change.

**Fix:** Split the reactive logic:
```r
# In mod_visualization_server:
filtered_plot_data <- reactive({
    req(data(), inputs$genre_filter())
    # filtering logic here
})

plot_reactive <- reactive({
    req(
        filtered_plot_data(),
        inputs$x_var(),
        inputs$y_var(),
        inputs$col_var(),
        inputs$alpha_var(),
        inputs$size_var()
    )
    # plot creation logic here
})
```

## 🔵 Maintainability Issues

### 1. Missing Error Handling

**Issue:** No error handling for file operations or plot generation.

**Fix for R/mod_download_report.R:**
```r
content = function(file) {
    tryCatch({
        # existing code
    }, error = function(e) {
        showNotification(
            paste("Error generating report:", e$message),
            type = "error",
            duration = 10
        )
        # Create a simple error file
        writeLines(
            paste("Report generation failed:", e$message),
            file
        )
    })
}
```

### 2. Hardcoded Choices

**Issue:** Genre and variable choices are hardcoded in the UI module.

**Fix:** Move choices to a separate configuration file or derive from data:
```r
# Create R/app_config.R:
get_numeric_choices <- function() {
    c("runtime", "imdb_rating", "imdb_num_votes", "critics_score", "audience_score")
}

get_color_choices <- function() {
    c("genre", "mpaa_rating", "critics_rating", "title_type", "audience_rating")
}

get_genre_choices <- function(data = NULL) {
    if (is.null(data)) {
        # fallback to hardcoded
    } else {
        c("All", unique(data$genre))
    }
}
```

### 3. Inconsistent Documentation

**Issue:** Some functions have incomplete or missing parameter documentation.

**Fix R/mod_visualization.R line 23:**
```r
# ❌ Current:
#' @param id Module namespace
#' @param data Reactive data
#' @param inputs List of reactive inputs from inputs module
#' 
#' @return Reactive plot object

# ✅ Improved:
#' @param id Character string. Module namespace ID.
#' @param data Reactive expression returning a data.frame with movies data.
#' @param inputs Named list of reactive expressions containing user input values.
#' @return Named list containing a reactive expression 'plot' that returns a ggplot object.
```

## 🟢 Security Considerations

### 1. File Path Validation

**Issue:** The download handler uses user-controlled date in filename without validation.

**Fix:**
```r
filename = function() {
    safe_date <- format(Sys.Date(), "%Y-%m-%d")
    paste0("movies_report_", safe_date, ".html")
}
```

### 2. Temporary File Cleanup

**Issue:** Temporary files might not be cleaned up on error.

**Fix:**
```r
# Use on.exit() for guaranteed cleanup:
content = function(file) {
    temp_dir <- tempdir()
    temp_rmd <- file.path(temp_dir, "temp_report.Rmd")
    temp_html <- file.path(temp_dir, "temp_report.html")
    
    on.exit({
        if (file.exists(temp_rmd)) unlink(temp_rmd)
        if (file.exists(temp_html)) unlink(temp_html)
    }, add = TRUE)
    
    # rest of the code
}
```

## 📋 Priority Recommendations

### High Priority (Fix Immediately)

1. ✅ Remove `library()` calls from `launch_app()`
2. ✅ Fix hardcoded package reference in download module
3. ✅ Add package loading to app.R
4. ✅ Implement centralized data filtering

### Medium Priority (Next Sprint)

1. ⏳ Fix grkstyle indentation throughout codebase
2. ⏳ Add comprehensive error handling
3. ⏳ Optimize reactive dependencies
4. ⏳ Move hardcoded choices to configuration

### Low Priority (Technical Debt)

1. ⏳ Improve documentation consistency
2. ⏳ Add input validation
3. ⏳ Consider using modules for better namespace management
4. ⏳ Add unit tests for core functions

## 🎯 Summary

**Strengths:**
- Good modular architecture following Shiny best practices
- Proper use of `moduleServer()` and namespacing
- Comprehensive data documentation
- Clean separation of UI and server logic

**Areas for Improvement:**
- Package structure and dependency management
- Code styling consistency
- Error handling and robustness
- Performance optimization of reactive expressions

## Next Steps

1. Address critical issues first (package loading, hardcoded references)
2. Apply style guide fixes systematically
3. Implement centralized data filtering
4. Add error handling to file operations
5. Optimize reactive dependencies

---

**Review Date:** April 29, 2026  
**Reviewer:** btw code_reviewer agent  
**Session ID:** stable_sparrow
