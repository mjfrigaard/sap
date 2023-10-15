testthat::describe("FE1: interactive scatter plot (two data sources, drop-down variable options)",
  code = {
    
    testthat::describe("FR1: data source", code = {
      
      testthat::it("T1 movies data source", code = {
        scatter_inputs <- list(
          y = "audience_score",
          x = "imdb_rating",
          z = "mpaa_rating",
          alpha = 0.5,
          size = 2,
          plot_title = "Enter plot title")
        app_graph <- scatter_plot(movies,
          x_var = scatter_inputs$x,
          y_var = scatter_inputs$y,
          col_var = scatter_inputs$z,
          alpha_var = scatter_inputs$alpha,
          size_var = scatter_inputs$size)
        expect_true(ggplot2::is.ggplot(app_graph))
      })

      testthat::it("T2 tidy movies data source", code = {
        ggp2_scatter_inputs <- list(
          x = "avg_rating",
          y = "length",
          z = "mpaa",
          alpha = 0.75,
          size = 3,
          plot_title = "Enter plot title"
        )
        tidy_ggp2_movies <- readRDS(test_path("fixtures",
                                      "tidy_ggp2_movies.rds"))
        app_graph <- scatter_plot(tidy_ggp2_movies,
          x_var = ggp2_scatter_inputs$x,
          y_var = ggp2_scatter_inputs$y,
          col_var = ggp2_scatter_inputs$z,
          alpha_var = ggp2_scatter_inputs$alpha,
          size_var = ggp2_scatter_inputs$size)
        expect_true(object = ggplot2::is.ggplot(app_graph))
        
      })
      
    })
  })
testthat::describe("FR3: color-coded data points & FR4: plot axis, legend & title",
  code = { 
  
  testthat::it("T3: color-coded data points", code = {

    test_logger(start = "T3", msg = "Tests FR3 (color)")
    
    scatter_inputs <- list(y = 'audience_score',
                       x = 'imdb_rating',
                       z = 'mpaa_rating',
                       alpha = 0.5,
                       size = 2,
                       plot_title = 'Enter plot title')
    
    vdiffr::expect_doppelganger(
      title = "FR3: color-coded data points", 
      fig = scatter_plot(movies, 
        x_var = scatter_inputs$x, 
        y_var = scatter_inputs$y, 
        col_var = scatter_inputs$z, 
        alpha_var = scatter_inputs$alpha, 
        size_var = scatter_inputs$size 
      ))
        
    test_logger(end = "T3", msg = "Tests FR3 (color)")
    
  })
    
  testthat::it("T4: plot axis, legend & title", code = {

    test_logger(start = "T4", msg = "Tests FR4 (legend/theme)")
                  
    scatter_inputs <- list(y = 'audience_score',
                       x = 'imdb_rating',
                       z = 'mpaa_rating',
                       alpha = 0.5,
                       size = 2,
                       plot_title = 'Enter plot title')
    
    vdiffr::expect_doppelganger(
      title = "FR4: plot axis, legend & title", 
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
                  scatter_inputs$x), "_", " "), 
          y = stringr::str_replace_all( 
                tools::toTitleCase( 
                  scatter_inputs$y), "_", " ") 
        ) + 
        ggplot2::theme_minimal() + 
        ggplot2::theme(legend.position = "bottom") 
    )
    
    test_logger(end = "T4", msg = "Tests FR4 (legend/theme)")
    
  })
  
  
})