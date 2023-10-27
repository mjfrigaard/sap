    #' var_input UI
    #'
    #' @param id Unique id for module instance.
    #'
    #' @keywords internal
    #'
    #' @return shiny UI module
    #' @export var_inputUI
    #'
    #' @description A shiny Module.
    #'
    #' @importFrom shiny NS tagList selectInput
    #' @importFrom shiny sliderInput textInput
    var_inputUI <- function(id){
    	ns <- shiny::NS(id)
    	shiny::tagList(
        shiny::selectInput(
          inputId = ns("y"),
          label = "Y-axis:",
          choices = c(
            "IMDB rating" = "imdb_rating",
            "IMDB number of votes" = "imdb_num_votes",
            "Critics Score" = "critics_score",
            "Audience Score" = "audience_score",
            "Runtime" = "runtime"
          ),
          selected = "audience_score"
        ),
        shiny::selectInput(
          inputId = ns("x"),
          label = "X-axis:",
          choices = c(
            "IMDB rating" = "imdb_rating",
            "IMDB number of votes" = "imdb_num_votes",
            "Critics Score" = "critics_score",
            "Audience Score" = "audience_score",
            "Runtime" = "runtime"
          ),
          selected = "imdb_rating"
        ),
        shiny::selectInput(
          inputId = ns("z"),
          label = "Color by:",
          choices = c(
            "Title Type" = "title_type",
            "Genre" = "genre",
            "MPAA Rating" = "mpaa_rating",
            "Critics Rating" = "critics_rating",
            "Audience Rating" = "audience_rating"
          ),
          selected = "mpaa_rating"
        ),
        shiny::sliderInput(
          inputId = ns("alpha"),
          label = "Alpha:",
          min = 0, max = 1, step = 0.1,
          value = 0.5
        ),
        shiny::sliderInput(
          inputId = ns("size"),
          label = "Size:",
          min = 0, max = 5,
          value = 2
        ),
        shiny::textInput(
          inputId = ns("plot_title"),
          label = "Plot title",
          placeholder = "Enter plot title"
        )
    	)
    }

    #' var_input Server
    #'
    #' @param id Unique id for module instance.
    #'
    #' @keywords internal
    #'
    #' @return shiny server module
    #' @export var_input_server
    #'
    #' @importFrom shiny NS moduleServer reactive
    var_input_server <- function(id){
    	moduleServer(
    		id,
    		function(
    			input,
    			output,
    			session
    			){

    				ns <- session$ns
    				send_message <- make_send_message(session)

    				# your code here
        return(
          list(
            "x" = shiny::reactive({
              input$x
            }),
            "y" = shiny::reactive({
              input$y
            }),
            "z" = shiny::reactive({
              input$z
            }),
            "alpha" = shiny::reactive({
              input$alpha
            }),
            "size" = shiny::reactive({
              input$size
            }),
            "plot_title" = shiny::reactive({
              input$plot_title
            })
            )
          )
    		}
    	)
    }

    # UI
    # var_inputUI('id')

    # server
    # var_input_server('id')
