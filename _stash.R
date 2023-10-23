# STANDALONE APP FUNCTION -------------------------------------------------------------------------------
#' Movies app standalone function
#'
#' Wrapper function for `shinyApp()`
#'
#' @param options arguments to pass to `options()`
#' @param ... arguments passed to UI
#' @param run where to launch app:
#'  * `p` = launch in viewer pane
#'  * `b` = launch in external browser
#'  * `w` = launch in window
#'
#'
#' @return shiny app
#'
#'
#' @seealso [mod_var_input_ui()], [mod_var_input_server()], [mod_scatter_display_ui()], [mod_scatter_display_server()]
#'
#' @import shiny
#'
#' @export
#'
movies_app <- function(options = list(), run = "p", ...) {
  if (interactive()) {
    display_type(run = run)
  }
    shinyApp(
      ui = movies_ui(),
      server = movies_server,
      options = options
    )
}


# APP.R -----------------------------------------------------------------
withr::with_options(new = list(shiny.autoload.r = FALSE), code = {
  if (!interactive()) {
    sink(stderr(), type = "output")
    tryCatch(
      expr = {
        # load package ----
        library(moviesApp)
      },
      error = function(e) {
        # load R/ folder ----
        pkgload::load_all()
      }
    )
  } else {
    # load R/ folder ----
    pkgload::load_all()
  }
  # create shiny object ----
    moviesApp::movies_app(
      options = list(test.mode = TRUE), run = 'p')
})

# GGPLOT2MOVIES::MOVIES APP FUNCTION ---------------------------------------------------------------------------
#' Development `ggplot2movies` app standalone function
#'
#' Wrapper function for `shinyAppDir()`
#'
#' @param options arguments to pass to `options()`
#' @param run where to launch app:
#'  * `p` = launch in viewer pane
#'  * `b` = launch in external browser
#'  * `w` = launch in window
#'  * `NULL` = `getOption(x = 'shiny.launch.browser')`
#'
#' @return shiny app
#'
#'
#' @export
ggp2_movies_app <- function(options = list(), run = "w", ...) {
  if (interactive()) {
    display_type(run = run)
  } 
    shinyAppDir(
    appDir = system.file("dev",
      package = "moviesApp"
    ),
    options = options
  )
}

# IGNORE FILES ---------------------------------------------------------
# .Rproj.user
# .Rhistory
# .RData
# .Ruserdata
# .DS_Store
# moviesApp.Rcheck/
# moviesApp*.tar.gz
# moviesApp*.tgz


# ^.*\.Rproj$
# ^\.Rproj\.user$
# ^moviesApp\.Rcheck$
# ^moviesApp.*\.tar\.gz$
# ^moviesApp.*\.tgz$

# SNAPSHOT TESTS -------------------------------------------------------------
testthat::describe(
  "Feature 1.2: Scatter Plot Configuration in Movie Review Application
    As a user who accesses the movie review application,
    I want the initial scatter plot pre-configured with variables and aesthetics,
    So that I can immediately see a meaningful visualization.",
  code = {
    testthat::it(
      "Scenario: Create scatter plot
          Given I have launched the movie review exploration app,
          When the scatter plot renders,
          Then the points on the x axis should represent 'Ratings'
          And the points on the y axis should represent 'Length'
          And the points should be colored by 'MPAA' rating
          And the size of the points should be set to '2'
          And the opacity of the points should be set to '0.5'",
      code = {
        test_logger(start = "T2", msg = "Tests initial x/y/z")

        scatter_inputs <- list(
          x = "imdb_rating",
          y = "audience_score",
          z = "mpaa_rating",
          alpha = 0.5,
          size = 2,
          plot_title = "Enter plot title"
        )

        vdiffr::expect_doppelganger(
          title = "Initial x y z axes",
          fig = scatter_plot(movies,
            x_var = scatter_inputs$x,
            y_var = scatter_inputs$y,
            col_var = scatter_inputs$z,
            alpha_var = scatter_inputs$alpha,
            size_var = scatter_inputs$size
          ) +
            ggplot2::labs(
              title = scatter_inputs$plot_title,
              x = stringr::str_replace_all(
                tools::toTitleCase(
                  scatter_inputs$x
                ), "_", " "
              ),
              y = stringr::str_replace_all(
                tools::toTitleCase(
                  scatter_inputs$y
                ), "_", " "
              )
            ) +
            ggplot2::theme_minimal() +
            ggplot2::theme(legend.position = "bottom")
        )

        test_logger(end = "T2", msg = "Tests initial x/y/z")
      }
    )
  }
)

testthat::describe("
  Feature: Scatter Plot Points Controlled by Dropdown Menus
    As a user creating a scatter plot,
    I want dropdown menus to select continuous variables for the x and y axes a
    And I want a dropdown menu to select a categorical variable for point coloration,
    So that I can effectively visualize the relationships and categories within the data.", 
  
  code = {
  testthat::it(
    "Scenario: Change x, y, color values for plotting
        When I launch the Scatter Plot Data Visualization
        And I select the variable 'Audience Score' for the x-axis
        And I select the variable 'IMDB Rating' for the y-axis
        And I select the variable 'Critics Rating' for the color
        Then the scatter plot should show 'Audience Score' on the x-axis
        And the scatter plot should show 'IMDB Rating' on the y-axis
        And the points on the scatter plot should be colored by 'Critics Rating'
  ",
    code = {
      test_logger(start = "T3", msg = "Tests updated x/y/z")

      scatter_inputs <- list(
        x = "audience_score",
        y = "imdb_rating",
        z = "critics_rating",
        alpha = 0.5,
        size = 2,
        plot_title = "Enter plot title"
      )

      vdiffr::expect_doppelganger(
        title = "Updated x, y, color",
        fig = scatter_plot(movies,
          x_var = scatter_inputs$x,
          y_var = scatter_inputs$y,
          col_var = scatter_inputs$z,
          alpha_var = scatter_inputs$alpha,
          size_var = scatter_inputs$size
        ) +
          ggplot2::labs(
            title = scatter_inputs$plot_title,
            x = stringr::str_replace_all(
              tools::toTitleCase(
                scatter_inputs$x
              ), "_", " "
            ),
            y = stringr::str_replace_all(
              tools::toTitleCase(
                scatter_inputs$y
              ), "_", " "
            )
          ) +
          ggplot2::theme_minimal() +
          ggplot2::theme(legend.position = "bottom")
      )

      test_logger(end = "T3", msg = "Tests updated x/y/z")
    }
  )
})


# library(covtracer)

# additional demo packages
# library(dplyr)
# library(withr)
# library(covr)

withr::with_options(new = list(covr.record_tests = TRUE), code = {
  cov <- covr::package_coverage()
  ttdf <- test_trace_df(cov)
})


tidy_ggp2_movies2 <- function(movies_data_url) {
  movies_data <- vroom::vroom(file = movies_data_url)
  # restructure
  long_data <- movies_data |>
    dplyr::rowwise() |>
    dplyr::mutate(genre_count = sum(c(
      Action, Animation, Comedy,
      Drama, Documentary,
      Romance, Short
    ))) |>
    tidyr::pivot_longer(
      cols = c(Action:Short),
      names_to = "genre_name",
      values_to = "genre_indicator"
    )
  # aggregate data
  aggregated_data <- long_data |>
    dplyr::filter(genre_indicator > 0) |>
    dplyr::group_by(title, year) |>
    dplyr:::summarise(
      genres = paste0(genre_name, collapse = ", "),
      .groups = "drop"
    )
  # join data
  joined_data <- dplyr::left_join(
    x = long_data,
    y = aggregated_data,
    by = intersect(
      x = names(long_data),
      y = names(aggregated_data)
    )
  ) |>
    dplyr::select(
      title, year, length,
      budget, rating, votes, mpaa,
      genre_count, genres
    ) |>
    dplyr::distinct()

  dplyr::mutate(joined_data,
    genre = dplyr::case_when(
      genre_count > 1 ~ "Multiple genres",
      genre_count == 1 ~ genres,
      TRUE ~ genres
    ),
    genre = factor(genre),
    genre_count = as.integer(genre_count),
    mpaa = dplyr::na_if(x = mpaa, y = ""),
    mpaa = factor(mpaa,
      levels = c("G", "PG", "PG-13", "R", "NC-17"),
      labels = c("G", "PG", "PG-13", "R", "NC-17")
    )
  ) |> 
    # convert to df
    as.data.frame()
}

# base version 
# bdat <- tidy_ggp2_movies("https://raw.githubusercontent.com/hadley/ggplot2movies/master/data-raw/movies.csv")

# dplyr & tidyr version
# tdat <- tidy_ggp2_movies2("https://raw.githubusercontent.com/hadley/ggplot2movies/master/data-raw/movies.csv")

# # get subset of multiple genres 
# bdat_genres <- dplyr::filter(bdat, genre_count > 2) |>
#   dplyr::select(title, genre_count, genre, genres)
# tdat_genres <- dplyr::filter(tdat, genre_count > 2) |>
#   dplyr::select(title, genre_count, genre, genres)
# # compare
# waldo::compare(bdat_genres, tdat_genres)
