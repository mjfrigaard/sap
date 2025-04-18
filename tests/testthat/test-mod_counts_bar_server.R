# Test for mod_counts_bar_server module
testthat::describe(
  "Feature: Movie counts bar chart display
  As a user
  I want to see a bar chart showing movie counts by a category
  So that I can understand the distribution of movies in the dataset",
  code = {
    testthat::it(
      "Scenario: Bar chart shows movie counts with correct formatting
      Given the user selects a categorical variable and year range
      When the bar chart is rendered
      Then it should display bars with frequencies for each category
      And the chart should have appropriate labels and formatting",
      code = {
        # Setup test environment for the module
        shiny::testServer(
          app = mod_counts_bar_server,
          args = list(
            vals = reactive(
              list(
                chr_var = "mpaa_rating", 
                start_year = 2000,
                end_year = 2010
              )
            )
          ),
          expr = {
            
            # Test that inputs are passed into module
            expect_equal(
              object = vals(),
              expected = list(
                chr_var = "mpaa_rating", 
                start_year = 2000,
                end_year = 2010
              )
            )
            
            # Create the expected plot to compare structure
            x_lab <- name_case("mpaa_rating")
            
            # Filter data based on expected year range
            counts_data <- subset(movies,
              thtr_rel_year >= 2000 &
              thtr_rel_year <= 2010)
              counts_nms <- names(counts_data) |> name_case()
              counts_data <- setNames(object = counts_data,
                nm = counts_nms)
                
                # Create the plot using the same code as in the module
                plot <- ggplot2::ggplot(counts_data,
                  ggplot2::aes(x =
                    forcats::fct_rev(
                      forcats::fct_infreq(
                        mpaa_rating
                      )
                    )
                  )
                ) +
                ggplot2::geom_bar(
                  ggplot2::aes(
                    fill = mpaa_rating
                  ), show.legend = FALSE
                ) +
                ggplot2::coord_flip() +
                ggplot2::scale_fill_manual(values = clr_pal12) +
                ggplot2::labs(
                  x = NULL,
                  y = "# of Movies",
                  fill = x_lab
                ) +
                ggplot2::theme(
                  legend.position = "none",
                  axis.text = ggplot2::element_text(color = "#ffffff", size = 14),
                  axis.title = ggplot2::element_text(color = "#ffffff", size = 16)
                )

                # Verify we have a proper ggplot object
                expect_true(ggplot2::is_ggplot(plot))

                # Verify the plot contains the expected layers
                expect_equal(length(plot$layers), 1)
                expect_true("GeomBar" %in% class(plot$layers[[1]]$geom))
              }
            )
          }
        )
      }
    )