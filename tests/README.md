---
editor_options: 
  markdown: 
    wrap: 72
---

# Tests and Coverage

20 March, 2025 11:51:42

-   [Coverage](#coverage)
-   [Unit Tests](#unit-tests)

This output is created by
[covrpage](https://github.com/yonicd/covrpage).

## Coverage {#coverage}

Coverage summary is created using the
[covr](https://github.com/r-lib/covr) package.

| Object                                                    | Coverage (%) |
|:----------------------------------------------------------|:------------:|
| gap                                                       |    85.27     |
| [R/run_app.R](../R/run_app.R)                             |     0.00     |
| [R/utils_tests.R](../R/utils_tests.R)                     |    53.85     |
| [R/mod_scatter_display.R](../R/mod_scatter_display.R)     |    56.76     |
| [R/golem_utils_server.R](../R/golem_utils_server.R)       |    77.78     |
| [R/golem_utils_ui.R](../R/golem_utils_ui.R)               |    87.94     |
| [R/app_config.R](../R/app_config.R)                       |    100.00    |
| [R/app_server.R](../R/app_server.R)                       |    100.00    |
| [R/app_ui.R](../R/app_ui.R)                               |    100.00    |
| [R/mod_aes_inputs.R](../R/mod_aes_inputs.R)               |    100.00    |
| [R/mod_var_inputs.R](../R/mod_var_inputs.R)               |    100.00    |
| [R/utils_scatter_display.R](../R/utils_scatter_display.R) |    100.00    |

<br>

## Unit Tests {#unit-tests}

Unit Test summary is created using the
[testthat](https://github.com/r-lib/testthat) package.

| file | n | time | error | failed | skipped | warning | icon |
|:--------|--------:|--------:|--------:|--------:|--------:|--------:|:--------|
| [test-golem_utils_server.R](testthat/test-golem_utils_server.R) | 13 | 0.135 | 0 | 0 | 0 | 0 |  |
| [test-golem_utils_ui.R](testthat/test-golem_utils_ui.R) | 51 | 0.261 | 0 | 0 | 0 | 0 |  |
| [test-golem-recommended.R](testthat/test-golem-recommended.R) | 10 | 1.873 | 0 | 0 | 1 | 0 | 🔶 |
| [test-mod_aes_inputs.R](testthat/test-mod_aes_inputs.R) | 1 | 0.079 | 0 | 0 | 0 | 0 |  |
| [test-mod_scatter_display.R](testthat/test-mod_scatter_display.R) | 1 | 0.058 | 0 | 0 | 0 | 0 |  |
| [test-mod_var_inputs.R](testthat/test-mod_var_inputs.R) | 1 | 0.044 | 0 | 0 | 0 | 0 |  |
| [test-utils_scatter_display.R](testthat/test-utils_scatter_display.R) | 1 | 0.047 | 0 | 0 | 0 | 0 |  |

<details open>

<summary>Show Detailed Test Results</summary>

| file | context | test | status | n | time | icon |
|:----------|:----------|:----------|:----------|----------:|----------:|:----------|
| [test-golem_utils_server.R](testthat/test-golem_utils_server.R#L2) | golem_utils_server | not_in works | PASS | 2 | 0.068 |  |
| [test-golem_utils_server.R](testthat/test-golem_utils_server.R#L7) | golem_utils_server | not_null works | PASS | 2 | 0.011 |  |
| [test-golem_utils_server.R](testthat/test-golem_utils_server.R#L12) | golem_utils_server | not_na works | PASS | 2 | 0.011 |  |
| [test-golem_utils_server.R](testthat/test-golem_utils_server.R#L17_L22) | golem_utils_server | drop_nulls works | PASS | 1 | 0.007 |  |
| [test-golem_utils_server.R](testthat/test-golem_utils_server.R#L26_L29) | golem_utils_server | %\|\|% works | PASS | 2 | 0.011 |  |
| [test-golem_utils_server.R](testthat/test-golem_utils_server.R#L37_L40) | golem_utils_server | %\|NA\|% works | PASS | 2 | 0.011 |  |
| [test-golem_utils_server.R](testthat/test-golem_utils_server.R#L48_L50) | golem_utils_server | rv and rvtl work | PASS | 2 | 0.016 |  |
| [test-golem_utils_ui.R](testthat/test-golem_utils_ui.R#L2) | golem_utils_ui | Test with_red_star works | PASS | 2 | 0.013 |  |
| [test-golem_utils_ui.R](testthat/test-golem_utils_ui.R#L10) | golem_utils_ui | Test list_to_li works | PASS | 3 | 0.016 |  |
| [test-golem_utils_ui.R](testthat/test-golem_utils_ui.R#L22_L28) | golem_utils_ui | Test list_to_p works | PASS | 3 | 0.016 |  |
| [test-golem_utils_ui.R](testthat/test-golem_utils_ui.R#L53) | golem_utils_ui | Test named_to_li works | PASS | 3 | 0.018 |  |
| [test-golem_utils_ui.R](testthat/test-golem_utils_ui.R#L66) | golem_utils_ui | Test tagRemoveAttributes works | PASS | 4 | 0.023 |  |
| [test-golem_utils_ui.R](testthat/test-golem_utils_ui.R#L82) | golem_utils_ui | Test undisplay works | PASS | 8 | 0.045 |  |
| [test-golem_utils_ui.R](testthat/test-golem_utils_ui.R#L110) | golem_utils_ui | Test display works | PASS | 4 | 0.019 |  |
| [test-golem_utils_ui.R](testthat/test-golem_utils_ui.R#L124) | golem_utils_ui | Test jq_hide works | PASS | 2 | 0.012 |  |
| [test-golem_utils_ui.R](testthat/test-golem_utils_ui.R#L132) | golem_utils_ui | Test rep_br works | PASS | 2 | 0.011 |  |
| [test-golem_utils_ui.R](testthat/test-golem_utils_ui.R#L140) | golem_utils_ui | Test enurl works | PASS | 2 | 0.012 |  |
| [test-golem_utils_ui.R](testthat/test-golem_utils_ui.R#L148) | golem_utils_ui | Test columns wrappers works | PASS | 16 | 0.061 |  |
| [test-golem_utils_ui.R](testthat/test-golem_utils_ui.R#L172) | golem_utils_ui | Test make_action_button works | PASS | 2 | 0.015 |  |
| [test-golem-recommended.R](testthat/test-golem-recommended.R#L3) | golem-recommended | app ui | PASS | 2 | 1.421 |  |
| [test-golem-recommended.R](testthat/test-golem-recommended.R#L13) | golem-recommended | app server | PASS | 4 | 0.064 |  |
| [test-golem-recommended.R](testthat/test-golem-recommended.R#L22_L24) | golem-recommended | app_sys works | PASS | 1 | 0.008 |  |
| [test-golem-recommended.R](testthat/test-golem-recommended.R#L31_L37) | golem-recommended | golem-config works | PASS | 2 | 0.016 |  |
| [test-golem-recommended.R](testthat/test-golem-recommended.R#L66) | golem-recommended | app launches | SKIPPED | 1 | 0.364 | 🔶 |
| [test-mod_aes_inputs.R](testthat/test-mod_aes_inputs.R#L39_L42) | mod_aes_inputs | Background: Initial … |  |  |  |  |

```         
   Given the movie review application is loaded
     And the initial alpha value is [0.7]
     And the initial size value is [3]
     And the initial title value is [NULL]: Scenario: Changing scatter plot size, alpha, and title values
         Given the movie review application is loaded
         When I choose the 3.5 for the size
         And I choose the 0.5 for the alpha
         And I choose the [new title] for title
         Then the scatter plot should show 3.5 on the size
         And the scatter plot should show 0.5 on the alpha
         And the title on the scatter plot should be 'new title'                                                                                                                                                                                                                                                                                                                                           |PASS    |  1| 0.079|     |
```

\|[test-mod_scatter_display.R](testthat/test-mod_scatter_display.R#L39_L49)\|mod_scatter_display
\|Scenario: Scatter plot initial x, y, color values Given the movie
review application is loaded When I view the initial scatter plot Then
the scatter plot should show ‘IMDB Rating’ on the x-axis And the scatter
plot should show ‘Audience Score’ on the y-axis And the points on the
scatter plot should be colored by ‘MPAA Rating’ And the size of the
points should be set to ‘2’ And the opacity of the points should be set
to ‘0.5’ And the plot title should be ‘Enter plot title’ \|PASS \| 1\|
0.058\| \|
\|[test-mod_var_inputs.R](testthat/test-mod_var_inputs.R#L39_L42)\|mod_var_inputs
\|Background: Initial scatter plot x, y, color values Given the movie
review application is loaded And the initial x-axis value is $$IMDB
Rating$$ And the initial y-axis value is $$Audience Score$$ And the
initial color value is $$MPAA Rating$$: Scenario: Changing scatter plot
x, y, and color values Given the movie review application is loaded When
I choose the $$Critics Score$$ for the x-axis And I choose the
$$Runtime$$ for the y-axis And I choose the $$Title type$$ for color
Then the scatter plot should show $$Critics score$$ on the x-axis And
the scatter plot should show $$Runtime$$ on the y-axis And the points on
the scatter plot should be colored by $$Title type$$ \|PASS \| 1\|
0.044\| \|
\|[test-utils_scatter_display.R](testthat/test-utils_scatter_display.R#L39)\|utils_scatter_display
\|Feature: Scatter plot data visualization As a film data analyst I want
to explore movie review data from IMDB & Rotten Tomatoes So that I can
analyze relationships between movie reivew variables

Background: Given I have data with IMDB & Rotten Tomatoes movie reviews
And the data contains continuous variables like ‘Audience Score’ And the
data contains categorical variables like ‘MPAA Rating’: Scenario: Create
scatter plot Given I have launched the movie review exploration app,
When the scatter plot renders, Then the points on the x axis should
represent ‘IMDB Rating’ And the points on the y axis should represent
‘Audience Score’ And the points should be colored by ‘MPAA’ rating And
the opacity of the points should be set to ‘0.5’ And the size of the
points should be set to ‘2’ And the plot title should be set to ‘Enter
plot title’ \|PASS \| 1\| 0.047\| \|

| Failed | Warning | Skipped |
|:-------|:--------|:--------|
| 🛑     | ⚠️      | 🔶      |

</details>

<details>

<summary>Session Info</summary>

| Field    | Value                        |
|:---------|:-----------------------------|
| Version  | R version 4.4.2 (2024-10-31) |
| Platform | x86_64-apple-darwin20        |
| Running  | macOS Sequoia 15.3.2         |
| Language | en_US                        |
| Timezone | America/Phoenix              |

| Package  | Version |
|:---------|:--------|
| testthat | 3.2.3   |
| covr     | 3.6.4   |
| covrpage | 0.2     |

</details>

<!--- Final Status : skipped/warning --->
