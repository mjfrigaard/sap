Tests and Coverage
================
31 October, 2023 07:47:16

- [Coverage](#coverage)
- [Unit Tests](#unit-tests)

This output is created by
[covrpage](https://github.com/yonicd/covrpage).

## Coverage

Coverage summary is created using the
[covr](https://github.com/r-lib/covr) package.

| Object                                                    | Coverage (%) |
|:----------------------------------------------------------|:------------:|
| gap                                                       |    85.71     |
| [R/run_app.R](../R/run_app.R)                             |     0.00     |
| [R/mod_plot.R](../R/mod_plot.R)                           |    56.76     |
| [R/golem_utils_server.R](../R/golem_utils_server.R)       |    77.78     |
| [R/golem_utils_ui.R](../R/golem_utils_ui.R)               |    87.94     |
| [R/app_config.R](../R/app_config.R)                       |    100.00    |
| [R/app_server.R](../R/app_server.R)                       |    100.00    |
| [R/app_ui.R](../R/app_ui.R)                               |    100.00    |
| [R/mod_plot_utils_server.R](../R/mod_plot_utils_server.R) |    100.00    |
| [R/mod_var.R](../R/mod_var.R)                             |    100.00    |

<br>

## Unit Tests

Unit Test summary is created using the
[testthat](https://github.com/r-lib/testthat) package.

| file                                                                  |   n |  time | error | failed | skipped | warning |
|:----------------------------------------------------------------------|----:|------:|------:|-------:|--------:|--------:|
| [test-golem_utils_server.R](testthat/test-golem_utils_server.R)       |  13 | 0.212 |     0 |      0 |       0 |       0 |
| [test-golem_utils_ui.R](testthat/test-golem_utils_ui.R)               |  51 | 0.306 |     0 |      0 |       0 |       0 |
| [test-golem-recommended.R](testthat/test-golem-recommended.R)         |  10 | 5.182 |     0 |      0 |       0 |       0 |
| [test-mod_plot_utils_server.R](testthat/test-mod_plot_utils_server.R) |   1 | 0.045 |     0 |      0 |       0 |       0 |
| [test-mod_plot.R](testthat/test-mod_plot.R)                           |   2 | 0.031 |     0 |      0 |       0 |       0 |
| [test-mod_var_input.R](testthat/test-mod_var_input.R)                 |   2 | 0.052 |     0 |      0 |       0 |       0 |

<details closed>
<summary>
Show Detailed Test Results
</summary>

| file                                                                     | context               | test                           | status |   n |  time |
|:-------------------------------------------------------------------------|:----------------------|:-------------------------------|:-------|----:|------:|
| [test-golem_utils_server.R](testthat/test-golem_utils_server.R#L2)       | golem_utils_server    | not_in works                   | PASS   |   2 | 0.097 |
| [test-golem_utils_server.R](testthat/test-golem_utils_server.R#L7)       | golem_utils_server    | not_null works                 | PASS   |   2 | 0.021 |
| [test-golem_utils_server.R](testthat/test-golem_utils_server.R#L12)      | golem_utils_server    | not_na works                   | PASS   |   2 | 0.018 |
| [test-golem_utils_server.R](testthat/test-golem_utils_server.R#L17_L22)  | golem_utils_server    | drop_nulls works               | PASS   |   1 | 0.013 |
| [test-golem_utils_server.R](testthat/test-golem_utils_server.R#L26_L29)  | golem_utils_server    | %\|\|% works                   | PASS   |   2 | 0.022 |
| [test-golem_utils_server.R](testthat/test-golem_utils_server.R#L37_L40)  | golem_utils_server    | %\|NA\|% works                 | PASS   |   2 | 0.019 |
| [test-golem_utils_server.R](testthat/test-golem_utils_server.R#L48_L50)  | golem_utils_server    | rv and rvtl work               | PASS   |   2 | 0.022 |
| [test-golem_utils_ui.R](testthat/test-golem_utils_ui.R#L2)               | golem_utils_ui        | Test with_red_star works       | PASS   |   2 | 0.018 |
| [test-golem_utils_ui.R](testthat/test-golem_utils_ui.R#L10)              | golem_utils_ui        | Test list_to_li works          | PASS   |   3 | 0.025 |
| [test-golem_utils_ui.R](testthat/test-golem_utils_ui.R#L22_L28)          | golem_utils_ui        | Test list_to_p works           | PASS   |   3 | 0.022 |
| [test-golem_utils_ui.R](testthat/test-golem_utils_ui.R#L53)              | golem_utils_ui        | Test named_to_li works         | PASS   |   3 | 0.022 |
| [test-golem_utils_ui.R](testthat/test-golem_utils_ui.R#L66)              | golem_utils_ui        | Test tagRemoveAttributes works | PASS   |   4 | 0.023 |
| [test-golem_utils_ui.R](testthat/test-golem_utils_ui.R#L82)              | golem_utils_ui        | Test undisplay works           | PASS   |   8 | 0.044 |
| [test-golem_utils_ui.R](testthat/test-golem_utils_ui.R#L110)             | golem_utils_ui        | Test display works             | PASS   |   4 | 0.022 |
| [test-golem_utils_ui.R](testthat/test-golem_utils_ui.R#L124)             | golem_utils_ui        | Test jq_hide works             | PASS   |   2 | 0.014 |
| [test-golem_utils_ui.R](testthat/test-golem_utils_ui.R#L132)             | golem_utils_ui        | Test rep_br works              | PASS   |   2 | 0.012 |
| [test-golem_utils_ui.R](testthat/test-golem_utils_ui.R#L140)             | golem_utils_ui        | Test enurl works               | PASS   |   2 | 0.024 |
| [test-golem_utils_ui.R](testthat/test-golem_utils_ui.R#L148)             | golem_utils_ui        | Test columns wrappers works    | PASS   |  16 | 0.068 |
| [test-golem_utils_ui.R](testthat/test-golem_utils_ui.R#L172)             | golem_utils_ui        | Test make_action_button works  | PASS   |   2 | 0.012 |
| [test-golem-recommended.R](testthat/test-golem-recommended.R#L3)         | golem-recommended     | app ui                         | PASS   |   2 | 0.030 |
| [test-golem-recommended.R](testthat/test-golem-recommended.R#L13)        | golem-recommended     | app server                     | PASS   |   4 | 0.023 |
| [test-golem-recommended.R](testthat/test-golem-recommended.R#L24_L26)    | golem-recommended     | app_sys works                  | PASS   |   1 | 0.010 |
| [test-golem-recommended.R](testthat/test-golem-recommended.R#L36_L42)    | golem-recommended     | golem-config works             | PASS   |   2 | 0.032 |
| [test-golem-recommended.R](testthat/test-golem-recommended.R#L72)        | golem-recommended     | app launches                   | PASS   |   1 | 5.087 |
| [test-mod_plot_utils_server.R](testthat/test-mod_plot_utils_server.R#L2) | mod_plot_utils_server | multiplication works           | PASS   |   1 | 0.045 |
| [test-mod_plot.R](testthat/test-mod_plot.R#L32)                          | mod_plot              | module ui works                | PASS   |   2 | 0.031 |
| [test-mod_var_input.R](testthat/test-mod_var_input.R#L30)                | mod_var_input         | module ui works                | PASS   |   2 | 0.052 |

</details>
<details>
<summary>
Session Info
</summary>

| Field    | Value                          |
|:---------|:-------------------------------|
| Version  | R version 4.3.1 (2023-06-16)   |
| Platform | x86_64-apple-darwin20 (64-bit) |
| Running  | macOS Sonoma 14.0              |
| Language | en_US                          |
| Timezone | America/Los_Angeles            |

| Package  | Version    |
|:---------|:-----------|
| testthat | 3.2.0.9000 |
| covr     | 3.6.3      |
| covrpage | 0.2        |

</details>
<!--- Final Status : pass --->
