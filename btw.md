---
# client: claude/claude-4-5-sonnet-latest
tools: [docs, env, files, ide, search, session, web]
---

# btwapp

> Test subject Shiny app-package for demonstrating btw capabilities

## Overview

**btwapp** is a test subject application for the `btw` package. It provides a realistic, well-structured Shiny app codebase that demonstrates best practices in modular app-package development. The app itself is a movies data explorer with interactive visualizations, filtering, and HTML report generation - typical features that make it a good representative example for testing `btw`'s subagents, tools, and skills on real-world code.

The application was generated using [Shiny Assistant](https://gallery.shinyapps.io/assistant/#) with a specific prompt (see README.md), resulting in a modular architecture that follows current Shiny best practices.

## Project Context

This is not a production application - it exists specifically to provide a realistic codebase for testing and demonstrating `btw` package functionality. The entire app is modifiable and serves as a testbed for `btw`'s ability to work with well-structured R package code, Shiny modules, and common app patterns.

## Key Design Decisions

- **Modular architecture** - Uses Shiny modules (`mod_*_ui` / `mod_*_server` pattern) following best practices for maintainable Shiny apps
- **App-package structure** - Packaged as an R package rather than standalone scripts, enabling proper dependency management, documentation, and installation
- **Centralized inputs** - The `mod_inputs` module returns reactive values consumed by other modules, creating a clean unidirectional data flow
- **Single exported function** - Only `launch_app()` is public API; all internal functions (`app_ui`, `app_server`, modules) remain unexported
- **Bundled dataset** - The `movies` dataset is shipped with the package (`data/movies.rda`) and accessed via `sap::movies`, removing the need for any external data dependency
- **Parameterized reporting** - R Markdown template uses `params` for dynamic content, with path handling for both development and installed contexts

## Quick Reference

| Aspect | Details |
|--------|---------|
| **Type** | R Package (Shiny app-package) |
| **Language** | R (≥ 3.5) |
| **UI Framework** | Shiny + bslib (Bootstrap 5) |
| **Data** | `sap::movies` (bundled, 651 obs × 34 vars) |
| **Key Dependencies** | shiny, bslib, ggplot2, DT, rmarkdown |
| **Dependency Management** | renv (lockfile present) |
| **Entry Point** | `launch_app()` function |
| **Dev Entry** | `app.R` file |

## Architecture

The app follows a **modular Shiny app-package pattern** where:

1. **User launches app** via `launch_app()` or by running `app.R`
2. **UI composition** happens in `app_ui()` using `bslib::page_sidebar()` layout
3. **Server logic** in `app_server()` orchestrates four modules with reactive data flow
4. **Modules communicate** via returned reactive values (not direct module-to-module calls)

### Reactive Data Flow

```
movies_data (reactive)
         ↓
    ┌────────────────────────────────────────────────────────────┐
    │                   mod_inputs_server                        │
    │  Returns: x_var, y_var, col_var, alpha_var, size_var,      │
    │           genre_filter                                     │
    └────────────────────────────────────────────────────────────┘
              ↓                ↓
    ┌──────────────────┐  ┌──────────────────┐
    │ mod_visualization│  │  mod_data_table  │
    │ Returns: plot    │  │  Returns: data   │
    └──────────────────┘  └──────────────────┘
              ↓                ↓
         ┌──────────────────────────┐
         │ mod_download_report      │
         │ Consumes: plot + data    │
         └──────────────────────────┘
```

### Module Responsibilities

**`mod_inputs`** - Centralized UI controls
- Provides selectInputs for x/y numeric variables, the color (categorical) variable, and the genre filter
- Provides sliderInputs for point alpha and point size
- Returns list of reactive values for consumption by other modules

**`mod_visualization`** - Scatter plot generation
- Delegates plot construction to the `scatter_plot()` utility, then layers on theme/labels
- Applies the genre filter so the plot stays in sync with the table
- Returns reactive plot object

**`mod_data_table`** - Filtered data display
- Shows DT::datatable with genre filtering applied
- Returns reactive filtered data

**`mod_download_report`** - HTML report generation
- Renders parameterized R Markdown template from `inst/rmd/report.Rmd`
- Injects current plot, data, and parameters into report
- Handles path resolution for both development and installed package contexts

## Directory Structure

```
sap/
├── DESCRIPTION              # Package metadata and dependencies
├── NAMESPACE                # Exports (only launch_app)
├── app.R                    # Development entry point (calls launch_app)
│
├── R/                       # Package R code
│   ├── launch_app.R         # Main exported function
│   ├── app_ui.R             # UI composition function
│   ├── app_server.R         # Server orchestration function
│   ├── data.R               # Roxygen documentation for the movies dataset
│   ├── scatter_plot.R       # Reusable ggplot2 scatter helper
│   ├── mod_inputs.R         # Input controls module
│   ├── mod_visualization.R  # Plot generation module
│   ├── mod_data_table.R     # Table display module
│   └── mod_download_report.R # Report download module
│
├── data/
│   └── movies.rda           # Bundled movies dataset (lazy-loaded)
│
├── inst/
│   ├── extdata/
│   │   └── movies.csv       # CSV copy of the movies dataset
│   └── rmd/
│       └── report.Rmd       # Parameterized report template
│
├── man/                     # roxygen2 generated documentation
│
├── renv/                    # Dependency management
│   ├── activate.R
│   └── settings.json
├── renv.lock                # Locked dependency versions
│
└── README.md                # Project documentation
```

## Key Components

### `launch_app()` - Application Entry Point
**Location:** `R/launch_app.R`

The only exported function. Loads required libraries and creates a `shinyApp()` object by combining `app_ui()` and `app_server`. Accepts `...` arguments passed to `shinyApp()`.

### `app_ui()` - UI Composition
**Location:** `R/app_ui.R`

Creates the page layout using `bslib::page_sidebar()`. Sidebar contains inputs and download modules; main area displays visualization and data table in a stacked layout.

### `app_server()` - Server Orchestration
**Location:** `R/app_server.R`

- Creates `movies_data` reactive that returns `sap::movies`
- Calls each module server function with appropriate arguments
- Passes reactive values between modules (inputs → viz/table → report)

### `scatter_plot()` - Plot Helper
**Location:** `R/scatter_plot.R`

Pure (non-reactive) helper that takes a data frame and column names for x, y, and color, plus numeric alpha and size, and returns a `ggplot` object. Uses tidy-evaluation (`.data[[...]]`) rather than the deprecated `aes_string()`. The visualization module wraps this output with theme and labels.

### Module Pattern
**All modules:** `R/mod_*.R`

Each module file contains paired `mod_*_ui()` and `mod_*_server()` functions:
- **UI function** - Takes `id` parameter, returns UI elements wrapped in namespace
- **Server function** - Uses `moduleServer()` for namespace isolation, returns reactive values as list

### Report Template
**Location:** `inst/rmd/report.Rmd`

R Markdown document with YAML `params` for:
- `plot_obj` - ggplot2 object
- `x_var`, `y_var` - selected variables
- `data` - filtered dataset
- `generated_on` - timestamp

Renders to HTML with `flatly` theme and floating TOC.

## Development Workflow

### Installation

```r
# From GitHub
install.packages("remotes")
remotes::install_github("mjfrigaard/sap")
```

### Running the App

```r
# As installed package
library(sap)
launch_app()

# In development (from package root)
source("app.R")  # or just run app.R in RStudio
```

### Using renv

The package uses `renv` for dependency management. To restore the locked environment:

```r
renv::restore()
```

### Documentation

```r
# View package help
?sap::launch_app
?sap::movies

# Generate documentation (during development)
devtools::document()
```

## Technical Details

### Core Dependencies

- **shiny** - Web application framework
- **bslib** - Bootstrap 5 theming and layout components
- **ggplot2** - Visualization generation
- **DT** - Interactive data tables
- **rmarkdown** - Report generation
- **tools** - Utility functions

### Data

The app uses the bundled `sap::movies` dataset (also available as a CSV in `inst/extdata/movies.csv`). The dataset contains 651 randomly sampled movies released before 2016 with 34 variables, including:

- **Identifiers and metadata:** title, title_type, genre, mpaa_rating, studio, runtime
- **Release dates:** theatrical and DVD release dates and components
- **Ratings:** IMDB rating and number of votes; Rotten Tomatoes critics_rating, critics_score, audience_rating, audience_score
- **Awards:** Oscar nomination/win indicators for best picture, actor, actress, director
- **Cast and crew:** director and top-five billed actors
- **URLs:** IMDB and Rotten Tomatoes links

The variables exposed in the app's x/y selectors are the most commonly compared numerics: `runtime`, `imdb_rating`, `imdb_num_votes`, `critics_score`, `audience_score`. The categorical filter and color aesthetic is `genre`.

### Module Communication Pattern

Modules don't call each other directly. Instead:
1. Server functions return lists of reactive expressions
2. Parent server (`app_server`) passes these reactives to other modules
3. Consuming modules call the reactive expressions when needed

This creates explicit, traceable dependencies and avoids circular module references.

## Developer Orientation

- **Start with `R/launch_app.R`** - Entry point that composes `app_ui()` and `app_server()`
- **Module pattern** - Each module has paired `_ui()` and `_server()` functions; server functions use `moduleServer()` for namespace isolation
- **Reactive flow** - `app_server.R` shows how modules connect: inputs → visualization + data table → download report
- **The whole app is modifiable** - No sacred cows; this is a test subject for `btw` features, so experiment freely

## Code Conventions

- **Module naming** - `mod_<name>_ui()` and `mod_<name>_server()` pattern
- **Namespace** - All modules use `ns <- NS(id)` for UI element namespacing
- **Returns** - Server modules return named lists of reactive expressions (not reactive values)
- **Documentation** - All functions use roxygen2 comments with `@param` and `@return`

## Resources

- [README.md](README.md) - Full project description and setup instructions
- [Shiny Modules Documentation](https://shiny.posit.co/r/articles/improve/modules/) - Understanding the module pattern
- [bslib Documentation](https://rstudio.github.io/bslib/) - UI framework details
