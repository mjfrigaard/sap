library(shiny)
library(ggplot2)

shinyApp(
	ui = fluidPage(
	  titlePanel("Capture ggplot2 warnings"),
	  mainPanel(
	    plotOutput("plot_with_warnings"),
	    tags$br(),
	    verbatimTextOutput('ggplot_warnings')
		    )
	),
	server = function(input, output, session) {

	  plot <- reactive({
	    ggplot(iris, 
		    aes(x = Sepal.Length, y = Sepal.Width)) +
		      geom_point() +
		      geom_smooth()
	  })
	
	 plot_errors <- reactive({
	    tryCatch({
	      print(plot())
	    }, message = function(e) {
	      return(e$message)
	    }, warning = function(e) {
	      return(e$message)
	    }, error = function(e) {
	      return(e$message)
	    })
	  })
	
	  output$plot_with_warnings <- renderPlot({
	    plot()
	  })
	
	  output$ggplot_warnings <- renderPrint({
	    plot_errors()
	  })
	}
)
