# app/view/display.R

# import data and plot modules
box::use(
  app/logic/data,
  app/logic/plot
)

#' display values ui
#' @export
ui <- function(id) {
box::use(
  shiny[NS, tagList, tags, plotOutput]
)
  ns <- NS(id)
  tagList(
    tags$br(),
    tags$blockquote(
      tags$em(
        tags$h6(
          "The code for this application comes from the ",
          tags$a("Building web applications with Shiny",
            href = "https://rstudio-education.github.io/shiny-course/"
          ),
          "tutorial"
        )
      )
    ),
    plotOutput(outputId = ns("scatterplot"))
  )
}

#' display values server
#' @export
server <- function(id, var_inputs) {

# load plotting, shiny, tools, and stringr functions
box::use(
  ggplot2 = ggplot2[...],
  shiny[NS, moduleServer, plotOutput, reactive, renderPlot],
  tools[toTitleCase],
  stringr[str_replace_all]
)

  moduleServer(id, function(input, output, session) {

    # use data$movies_data() ----
    movies <- data$movies_data()

      inputs <- reactive({
        plot_title <- toTitleCase(var_inputs$plot_title())
        list(
          x = var_inputs$x(),
          y = var_inputs$y(),
          z = var_inputs$z(),
          alpha = var_inputs$alpha(),
          size = var_inputs$size(),
          plot_title = plot_title
        )
      })

    output$scatterplot <- renderPlot({
      # use plot$point_plot() ----
      plot <- plot$point_plot(
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
            toTitleCase(
              inputs()$x
            ),
            "_",
            " "
          ),
          y = str_replace_all(
            toTitleCase(
              inputs()$y
            ),
            "_",
            " "
          )
        ) +
        theme_minimal() +
        theme(legend.position = "bottom")
    })
  })
}
