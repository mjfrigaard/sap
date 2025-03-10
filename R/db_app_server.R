#' Define the Server Logic for the Shiny Application
#'
#' This function sets up server-side logic, including reactive movie data,
#' input modules, and filtering operations. It initializes reactive expressions
#' for user input and manages interactions between different UI components.
#'
#' @param input,output,session Standard Shiny server function arguments.
#'
#' @return A `shiny.server` function handling user inputs and outputs.
#' 
#' @export
#'
db_app_server <- function(input, output, session, .dev = FALSE) {

  all_movies <- reactive({
    con <- db_con("sap", "movies.db")
    all_movies <- join_movies_tbls(con = con)
    return(all_movies)
    DBI::dbDisconnect(con) # close connection
  })

    nums <- mod_slider_input_server("sliders")

    vars <- mod_select_input_server('selects')

    txts <- mod_text_input_server('text')

    filtered_movies <- mod_filters_server(
      id = "filters",
      movies = all_movies,
      var = vars,
      num = nums,
      txt = txts)


    mod_points_plotly_server(
      id = 'plotly',
      data = filtered_movies,
      vars = vars)


    if (.dev) {
      output$vals <- renderPrint({
        vals <- reactiveValuesToList(x = input, all.names = TRUE)
        print(str(vals))
      })
    }


}
