#' plot_display UI
#'
#' @param id Unique id for module instance.
#'
#' @return shiny UI module
#' @export plot_displayUI
#'
#' @description A shiny Module.
#'
#' @importFrom shiny NS tagList tags
#' @importFrom shiny plotOutput
plot_displayUI <- function(id){
	ns <- shiny::NS(id)
	shiny::tagList(
    shiny::tags$br(),
    shiny::tags$blockquote(
      shiny::tags$em(
        shiny::tags$h6(
          "The code for this application comes from the ",
          shiny::tags$a("Building web applications with Shiny",
            href = "https://rstudio-education.github.io/shiny-course/"
          ),
          "tutorial"
        )
      )
    ),
    shiny::plotOutput(outputId = ns("scatterplot"))
	)
}

#' plot_display Server
#'
#' @param id Unique id for module instance.
#'
#' @keywords internal
plot_display_server <- function(id, var_inputs){
	moduleServer(
		id,
		function(
			input,
			output,
			session
			){

				ns <- session$ns
				send_message <- make_send_message(session)

				send_message("show-packer",
				  text = "this is a message from your plot_display module")

				# your code here
    movies <- lap::movies

    inputs <- shiny::reactive({
      plot_title <- tools::toTitleCase(var_inputs$plot_title())
      list(
        x = var_inputs$x(),
        y = var_inputs$y(),
        z = var_inputs$z(),
        alpha = var_inputs$alpha(),
        size = var_inputs$size(),
        plot_title = plot_title
      )
    })

    output$scatterplot <- shiny::renderPlot({
      plot <- point_plot(
        df = movies,
        x_var = inputs()$x,
        y_var = inputs()$y,
        col_var = inputs()$z,
        alpha_var = inputs()$alpha,
        size_var = inputs()$size
      )
      plot +
        ggplot2::labs(
          title = inputs()$plot_title,
            x = stringr::str_replace_all(
                  tools::toTitleCase(
                      inputs()$x),
                    "_",
                  " "),
            y = stringr::str_replace_all(
                  tools::toTitleCase(
                      inputs()$y),
                  "_",
                " ")) +
        ggplot2::theme_minimal() +
        ggplot2::theme(legend.position = "bottom")
    })
		}
	)
}

# UI
# plot_displayUI('id')

# server
# plot_display_server('id')
