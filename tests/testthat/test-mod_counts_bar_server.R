# Create test for mod_counts_bar_server function
shiny::testServer(
  app = mod_counts_bar_server,
  # Provide mock reactive values as input to the module
  args = list(
    vals = reactive(
      list(
        chr_var = "Mpaa Rating",
        start_year = 2000,
        end_year = 2010
      )
    )
  ),
  expr = {
    # Verify that output$hbar_graph exists and is a renderPlot
    expect_true(inherits(output$hbar_graph, "shiny.render.function"))
    
    # We can't easily test the actual plot output directly, but we can 
    # verify the module doesn't throw errors when executed
    session$flushReact()
    
    # Check that the plot is created when valid inputs are provided
    expect_silent(output$hbar_graph())
    
    # Change vals and verify module still works with different inputs
    vals <- reactive(
      list(
        chr_var = "Genre",
        start_year = 1990,
        end_year = 2005
      )
    )
    
    session$flushReact()
    expect_silent(output$hbar_graph())
  }
)