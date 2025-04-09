# app/view/display.R

# import data and plot modules
box::use(
  app / logic / data,
  app / logic / plot
)


#' display ui
#' @export
ui <- function(id) {
  box::use(
    shiny[NS, tagList, tags, plotOutput]
  )
  ns <- NS(id)
  tagList(
    plotOutput(outputId = ns("scatterplot")),
    tags$hr(),
    tags$blockquote(
        "The code for this application comes from the ",
        tags$a("Building web applications with Shiny",
          href = "https://rstudio-education.github.io/shiny-course/"
        ),
        "tutorial"
      )
    )
}

#' display server
#' @export
server <- function(id, var_inputs, aes_inputs) {
  
  # load 
  box::use(
    ggplot2[labs, theme_minimal, theme],
    shiny[NS, moduleServer, plotOutput, reactive, renderPlot],
    tools[toTitleCase],
    stringr[str_replace_all]
  )

  moduleServer(id, function(input, output, session) {
    
    # use data$movies_data() ----
    movies <- data$movies_data()

    inputs <- reactive({
      plot_title <- toTitleCase(as.character(aes_inputs()$plot_title))
      list(
        x = var_inputs()$x,
        y = var_inputs()$y,
        z = var_inputs()$z,
        alpha = aes_inputs()$alpha,
        size = aes_inputs()$size,
        plot_title = plot_title
      )
    })

    output$scatterplot <- renderPlot({
      # use plot$scatter_plot() ----
      plot <- plot$scatter_plot(
        df = movies,
        x_var = inputs()$x,
        y_var = inputs()$y,
        col_var = inputs()$z,
        alpha_var = inputs()$alpha,
        size_var = inputs()$size
      )
      plot +
        labs(
          title = inputs()$plot_title,
          x = str_replace_all(
            toTitleCase(inputs()$x ), "_", " " ),
          y = str_replace_all(
            toTitleCase(inputs()$y), "_", " " )
        ) +
        theme_minimal() +
        theme(legend.position = "bottom")
    })
  })
}