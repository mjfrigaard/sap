
# `btw("@platform_info")`

## Context

```
"@platform_info"
<system_info>
R_VERSION: R version 4.5.1 (2025-06-13)
OS: macOS Sequoia 15.6
SYSTEM: x86_64, darwin20
UI: Positron (a VS Code equivalent)
LANGUAGE: (EN)
LOCALE: en_US.UTF-8
ENCODING: en_US.UTF-8
TIMEZONE: America/Phoenix
DATE: Monday, August 18, 2025 (2025-08-18)
</system_info>
```

# Prompt: `sap` architecture 

> "You are in the root directory of the sap package (sap stands for [S]hiny [A]pp [P]ackage ). Describe the architecture of the package and application, using mermaid diagrams to illustrate connections between the functions (in R/), the files in the inst/ folder, the tests in the tests/ folder."

## Tool calling

I'll explore the structure of the sap package to understand its architecture and create diagrams illustrating the connections.

```bash
◯ [tool call] btw_tool_files_list_files(path = ".", type = "directory", `_intent` = "List all directories in the package root")
● #> | path | type | size | modification_time |
  #> |------|------|------|-------------------|
  #> | R | directory | 1K | 2025-10-22 08:01:23 |
  #> | data | directory | 192 | 2025-10-20 13:35:52 |
  #> | data-raw | directory | 192 | 2025-10-20 13:35:52 |
  #> …
◯ [tool call] btw_tool_files_list_files(path = "R", type = "file", `_intent` = "List R source files")
● #> | path | type | size | modification_time |
  #> |------|------|------|-------------------|
  #> | R/compare_plot.R | file | 2.08K | 2025-10-20 14:04:01 |
  #> | R/count_bar_plot.R | file | 1.46K | 2025-10-20 14:04:01 |
  #> | R/data.R | file | 2.56K | 2025-10-20 13:35:52 |
  #> …
◯ [tool call] btw_tool_files_list_files(path = "inst", type = "any", `_intent` = "List files in inst directory")
● #> | path | type | size | modification_time |
  #> |------|------|------|-------------------|
  #> | inst/dev | directory | 96 | 2025-10-20 14:04:01 |
  #> | inst/dev/stash | file | 8.36K | 2025-10-20 14:04:01 |
  #> | inst/extdata | directory | 128 | 2025-10-20 13:35:52 |
  #> …
◯ [tool call] btw_tool_files_list_files(path = "tests", type = "any", `_intent` = "List test files")
● #> | path | type | size | modification_time |
  #> |------|------|------|-------------------|
  #> | tests/testthat | directory | 608 | 2025-10-20 14:04:01 |
  #> | tests/testthat/fixtures | directory | 128 | 2025-10-20 14:04:01 |
  #> | tests/testthat/fixtures/make-tidy_ggp2_movies.R | file | 1.49K | 2025-10-20 14:04:01 |
  #> …
```

Let me examine some key files to understand the application structure better:

```bash
◯ [tool call] btw_tool_files_read_text_file(path = "R/nav_ui.R", `_intent` = "Read the main UI file")
● #> ```R
  #> #' User Interface for the Shiny Application
  #> #'
  #> #' This function defines the user interface for the Shiny application,
  #> #' integrating Bootstrap and a custom JavaScript file.
  #> …
◯ [tool call] btw_tool_files_read_text_file(path = "R/nav_server.R", `_intent` = "Read the main server file")
● #> ```R
  #> #' Application Navigation Server Logic
  #> #'
  #> #' @param input,output Shiny server input and output objects.
  #> #'
  #> …
◯ [tool call] btw_tool_files_read_text_file(path = "R/launch_app.R", `_intent` = "Read the launch app function")
● #> ```R
  #> #' Launch the Shiny Application
  #> #'
  #> #' This function initializes and launches the Shiny application with specified
  #> #' options and settings.
  #> …
◯ [tool call] btw_tool_files_read_text_file(path = "R/data.R", `_intent` = "Read data documentation")
● #> ```R
  #> #' @title IMDB movies data
  #> #'
  #> #' @description
  #> #' Movie review data. Note: these data come from the [Building Web Applications with shiny
course](https://rstudio-education.github.io/shiny-course/).
  #> …
```

Now let me examine a few module files to understand the module pattern:

```bash
◯ [tool call] btw_tool_files_read_text_file(path = "R/mod_compare_vars.R", ...)
● #> ```R
  #> #' UI for variable comparison module
  #> #'
  #> #' Creates inputs for selecting variables to compare in a scatter plot with
  #> #' customizable appearance options. This function is designed to work together
  #> …
◯ [tool call] btw_tool_files_read_text_file(path = "R/mod_compare_point.R", ...)
● #> ```R
  #> #' UI for comparison point chart module
  #> #'
  #> #' Creates a plotly scatterplot visualization for comparing two variables.
  #> #' This function is designed to work together with [mod_compare_point_server()].
  #> …
◯ [tool call] btw_tool_files_read_text_file(path = "R/mod_report.R", `_intent` = "Read report module")
● #> ```R
  #> #' Report download UI
  #> #'
  #> #' @param id Module ID
  #> #'
  #> …
```

Now let me check some utility functions and test files:

```bash
◯ [tool call] btw_tool_files_read_text_file(path = "R/compare_plot.R", `_intent` = "Read compare_plot utility")
● #> ```R
  #> #' Create an Interactive Scatter Plot for Comparing Variables
  #> #'
  #> #' This function creates an interactive scatter plot using plotly to compare two
  #> #' variables with points colored by a third variable.
  #> …
◯ [tool call] btw_tool_files_read_text_file(path = "tests/testthat/test-mod_compare_vars_server.R", ...)
● #> ```R
  #> # Define a test for the compare_vars module
  #> describe(
  #>  "Feature: Variable Selection Prevention of Duplicate X/Y Variables
  #>  As a user
  #> …
◯ [tool call] btw_tool_files_read_text_file(path = "inst/rmd/report_template.Rmd", ...)
● #> ````Rmd
  #> ---
  #> title: "Movie Analysis Report"
  #> date: "`r format(Sys.time(), '%B %d, %Y')`"
  #> output:
  #> …
```

Perfect! Now I have a comprehensive understanding of the sap package architecture. Let me create detailed mermaid diagrams to illustrate the 
structure.

## SAP Package Architecture Overview

The **sap** (Shiny App Package) is a modular Shiny application for exploring IMDB movie data. It follows best practices for Shiny app development with a clear separation of concerns using Shiny modules.

### 1. High-Level Application Architecture

```mermaid
graph TD
    Launch[launch_app] -->|creates| App[shinyApp]
    App -->|UI| NavUI[nav_ui]
    App -->|Server| NavServer[nav_server]
    
    NavUI -->|provides| Theme[bslib theme & layout]
    NavUI -->|contains| Tabs[4 Nav Panels]
    
    Tabs --> Compare[Compare Tab]
    Tabs --> Counts[Counts Tab]
    Tabs --> Dist[Distributions Tab]
    Tabs --> Awards[Awards Tab]
    
    NavServer -->|coordinates| Modules[Module Servers]
    
    Data[(movies data)] -.->|used by| Modules
    ExtData[inst/extdata/movies.csv] -.->|source| Data
    
    style Launch fill:#2979ff
    style App fill:#121212,color:#fff
    style Data fill:#bdbdbd
```

### 2. Module Architecture by Feature

```mermaid
graph LR
    subgraph Compare Feature
        CmpVarsUI[mod_compare_vars_ui] -->|inputs| CmpVarsSrv[mod_compare_vars_server]
        CmpVarsSrv -->|reactive values| CmpPtSrv[mod_compare_point_server]
        CmpPtUI[mod_compare_point_ui] -->|plot output| CmpPtSrv
        CmpPtSrv -->|uses| CmpPlot[compare_plot]
    end
    
    subgraph Counts Feature
        CntVarsUI[mod_counts_vars_ui] -->|inputs| CntVarsSrv[mod_counts_vars_server]
        CntVarsSrv -->|reactive values| CntMods[Count Display Modules]
        CntMods --> CntBar[mod_counts_bar]
        CntMods --> CntWaffle[mod_counts_waffle]
        CntMods --> CntVbox[mod_counts_vbox]
        CntMods --> CntTbl[mod_counts_tbl]
        CntBar -->|uses| BarPlot[count_bar_plot]
    end
    
    subgraph Dist Feature
        DistVarsUI[mod_dist_vars_ui] -->|inputs| DistVarsSrv[mod_dist_vars_server]
        DistVarsSrv -->|reactive values| DistMods[Dist Display Modules]
        DistMods --> DistBox[mod_dist_box]
        DistMods --> DistCloud[mod_dist_raincloud]
        DistMods --> DistTbl[mod_dist_tbl]
        DistBox -->|uses| Summary[dist_var_summary]
    end
    
    subgraph Awards Feature
        AwardsVarsUI[mod_awards_vars_ui] -->|inputs| AwardsVarsSrv[mod_awards_vars_server]
        AwardsVarsSrv -->|reactive values| AwardsMods[Awards Display Modules]
        AwardsMods --> AwardsPt[mod_awards_point]
        AwardsMods --> AwardsTbl[mod_awards_tbl]
        AwardsPt -->|uses| GetRecipients[get_award_recipients]
    end
    
    style CmpVarsSrv fill:#2979ff
    style CntVarsSrv fill:#2979ff
    style DistVarsSrv fill:#2979ff
    style AwardsVarsSrv fill:#2979ff
```

### 3. Module Communication Pattern

```mermaid
graph TD
    UI[Module UI Function] -->|namespace| NS[NS id]
    UI -->|creates| Inputs[Input Controls]
    
    Server[Module Server Function] -->|receives| Inputs
    Server -->|processes| Logic[Business Logic]
    Logic -->|updates| Outputs[Output/Renders]
    Logic -->|returns| Reactive[Reactive Values]
    
    Reactive -->|consumed by| DownstreamMod[Downstream Modules]
    
    NavSrv[nav_server] -->|calls vars module| VarsMod[*_vars_server]
    VarsMod -->|returns reactive| Values[Selected Values]
    NavSrv -->|passes values to| DisplayMod[Display Modules]
    DisplayMod -->|renders| Visual[Plots/Tables]
    
    style Server fill:#2979ff
    style Reactive fill:#bdbdbd
```

### 4. Utility Functions & Data Flow

```mermaid
graph LR
    subgraph Helper Functions
        NameCase[name_case] -.->|formats| Labels[UI Labels]
        Desym[desym] -.->|removes symbols| Params[Report Params]
        ExtractVar[extract_var_name] -.->|extracts names| VarNames
        GetCol[get_column_name] -.->|retrieves cols| Columns
        DisplayType[display_type] -.->|launch helper| App
        LogrMsg[logr_msg] -.->|logging| AllModules[All Modules]
    end
    
    subgraph Plot Functions
        ComparePlot[compare_plot] -->|creates| ScatterPlot[plotly scatter]
        CountBarPlot[count_bar_plot] -->|creates| BarChart[ggplot bar]
        DistSummary[dist_var_summary] -->|computes| Statistics[Summary Stats]
        GetAwards[get_award_recipients] -->|filters| AwardsData[Awards Subset]
    end
    
    Movies[(movies data)] -->|source| PlotFunctions[Plot Functions]
    
    style LogrMsg fill:#2979ff
    style Movies fill:#bdbdbd
```

### 5. Testing Architecture

```mermaid
graph TD
    subgraph Test Structure
        TestThat[tests/testthat.R] -->|runs| Tests[Test Files]
        Helper[helper.R] -.->|provides| Utils[Test Utilities]
        
        Tests --> CompareTests[test-mod_compare_*.R]
        Tests --> CountTests[test-mod_counts_*.R]
        Tests --> DistTests[test-mod_dist_*.R]
        Tests --> AwardsTests[test-mod_awards_*.R]
        
        Fixtures[fixtures/] -->|provides| TestData[tidy_ggp2_movies.rds]
        TestData -.->|test data| AllTests[All Test Files]
    end
    
    subgraph Module Tests
        CompareTests -->|testServer| CmpVarsSrv[mod_compare_vars_server]
        CompareTests -->|testServer| CmpPtSrv[mod_compare_point_server]
        
        CountTests -->|testServer| CntModules[Count Modules]
        DistTests -->|testServer| DistModules[Dist Modules]
        AwardsTests -->|testServer| AwardsModules[Awards Modules]
    end
    
    CmpVarsSrv -.->|validates| Inputs[Input Updates]
    CmpPtSrv -.->|validates| Outputs[Plot Renders]
    
    style TestThat fill:#2979ff
    style Fixtures fill:#bdbdbd
```

### 6. File Organization & Resources

```mermaid
graph LR
    subgraph Package Structure
        Root[sap/] --> R[R/]
        Root --> Inst[inst/]
        Root --> Tests[tests/]
        Root --> Data[data/]
        Root --> Man[man/]
        Root --> Vignettes[vignettes/]
    end
    
    subgraph R Functions
        R --> Modules[Module Files mod_*.R]
        R --> Utils[Utility Files]
        R --> Main[nav_ui.R & nav_server.R]
        R --> Launch[launch_app.R]
        R --> DataDoc[data.R]
    end
    
    subgraph inst Resources
        Inst --> ExtData[extdata/movies.csv]
        Inst --> Rmd[rmd/report_template.Rmd]
        Inst --> WWW[www/*.png]
        Inst --> Prompts[prompts/btw-clipboard.md]
        Inst --> Dev[dev/stash]
    end
    
    subgraph tests Structure
        Tests --> TT[testthat/]
        TT --> TestFiles[test-*.R]
        TT --> HelperFile[helper.R]
        TT --> Fix[fixtures/]
        Fix --> TestDataRds[tidy_ggp2_movies.rds]
        Fix --> MakeData[make-tidy_ggp2_movies.R]
    end
    
    Data -->|contains| MoviesRda[movies.rda]
    
    style Root fill:#121212,color:#fff
    style Modules fill:#2979ff
    style ExtData fill:#bdbdbd
```

### 7. Report Generation Flow

```mermaid
sequenceDiagram
    participant User
    participant ReportUI as mod_report_ui
    participant ReportSrv as mod_report_server
    participant NavSrv as nav_server
    participant Template as report_template.Rmd
    participant RMarkdown as rmarkdown::render
    
    User->>ReportUI: Click Download Report
    ReportUI->>ReportSrv: trigger download
    
    NavSrv->>ReportSrv: pass scatter_values
    NavSrv->>ReportSrv: pass count_values
    NavSrv->>ReportSrv: pass dist_values
    NavSrv->>ReportSrv: pass award_values
    
    ReportSrv->>ReportSrv: collect reactive values
    ReportSrv->>ReportSrv: desym(params)
    
    ReportSrv->>Template: copy to temp dir
    ReportSrv->>RMarkdown: render with params
    
    RMarkdown->>Template: knit with params
    Template->>Template: create plots using sap functions
    
    Template-->>RMarkdown: HTML output
    RMarkdown-->>User: Download report-YYYY-MM-DD.html
```

## Key Architecture Patterns

### **Modular Design**

Each feature (Compare, Counts, Distributions, Awards) follows a consistent pattern:
- **Vars Module**: Handles input controls and returns reactive values
- **Display Modules**: Receive reactive values and render visualizations/tables
- **Utility Functions**: Provide plotting and data manipulation logic

### **Separation of Concerns**

- `nav_ui.R` / `nav_server.R`: Top-level navigation and layout
- `mod_*_vars_*.R`: Input collection modules
- `mod_*_point/bar/box_*.R`: Visualization modules
- `mod_*_tbl_*.R`: Table display modules
- Utility functions in separate files (plotting, formatting, logging)

### **Resource Management**

- **inst/extdata/**: Raw data files
- **inst/rmd/**: R Markdown templates for reports
- **inst/www/**: Static assets (images)
- **data/**: Processed R data objects

### **Testing Strategy**

- One test file per module server function
- `testServer()` for testing module logic
- Fixtures provide consistent test data
- Helper functions in `helper.R` for shared test utilities

### **Logging Integration**

- `logr_msg()` wrapper provides structured logging throughout
- Different log levels (DEBUG, INFO, WARN, ERROR) for tracing execution

This architecture demonstrates best practices for building production-ready Shiny applications as R packages!