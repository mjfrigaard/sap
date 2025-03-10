#' Reactable table shiny module (UI)
#'
#' @param id shiny module id
#'
#' @export
#' 
mod_filters_ui <- function(id) {
  ns <- shiny::NS(id)
  shiny::tagList(
    reactable::reactableOutput(ns("tbl"))
  )
}
#' Reactable table shiny module (server)
#'
#' @param id shiny module id
#' @param movies movies connection
#' @param num slider inputs
#' @param var variable inputs
#' @param txt text inputs
#'
#' @export
#' 
mod_filters_server <- function(id, movies, num, var, txt) {
  shiny::moduleServer(id, function(input, output, session) {
    ns <- session$ns

    # observe({
    #   browser()

    filtered_nums <- reactive({
      dplyr::filter(local(movies()),
        reviews >= !!num()[["reviews"]],
        oscars >= !!num()[["oscars"]],
        year >= !!num()[["minyear"]],
        year <= !!num()[["maxyear"]],
        box_office >= !!num()[["minboxoffice"]],
        box_office <= !!num()[["maxboxoffice"]]
      ) |>
        dplyr::arrange(oscars) |>
        dplyr::collect()
    }) |>
      # update when slider inputs change
      bindEvent(movies(), num())

    filtered_vars <- reactive({
      # Optional: filters
      if (!!var()[["genre"]] != "All") {
        filter_regex <- paste0(var()[["genre"]], "|", var()[["genre"]], ",")
        filtered <- dplyr::filter(filtered_nums(),
                          stringr::str_detect(string = genre, filter_regex))
      } else {
        filtered <- filtered_nums()
      }
      return(filtered)
    }) |>
      # update when slider or select inputs change
      bindEvent(movies(), num(), var())

    filtered_txts <- reactive({
      # first condition on both text inputs being filled
      if (!is.null(txt()[["cast"]]) && !!txt()[["cast"]] != "" & !is.null(txt()[["director"]]) && !!txt()[["director"]] != "") {
        dir_regex <- txt()[["director"]]
        cast_regex <- txt()[["cast"]]
        filtered <- dplyr::filter(filtered_vars(),
                  stringr::str_detect(string = cast, cast_regex),
                  stringr::str_detect(string = director, dir_regex))
      # now only director
      } else if (!is.null(txt()[["director"]]) && !!txt()[["director"]] != "") {
        filter_regex <- txt()[["director"]]
        filtered <- dplyr::filter(filtered_vars(),
                          stringr::str_detect(string = director, filter_regex))
        # only cast
      } else if (!is.null(txt()[["cast"]]) && !!txt()[["cast"]] != "") {
        filter_regex <- txt()[["cast"]]
        filtered <- dplyr::filter(filtered_vars(),
                          stringr::str_detect(string = cast, filter_regex))
        # neither
      } else {
        filtered <- filtered_vars()
      }
        # Add column which says whether the movie won any Oscars
        # Be a little careful in case we have a zero-row data frame
        filtered$has_oscar <- character(nrow(filtered))
        filtered$has_oscar[filtered$oscars == 0] <- "No"
        filtered$has_oscar[filtered$oscars >= 1] <- "Yes"
        return(filtered)
    }) |>
      # update when slider, select, or text inputs change
      bindEvent(movies(), num(), var(), txt())

    observe({
      output$tbl <- reactable::renderReactable({


        reactable::reactable(
          dplyr::select(
            filtered_txts(),
            title, genre, reviews, oscars, has_oscar,
            year, box_office, director, cast,
            # include text values for x and y
            dplyr::all_of(c(var()[["yvar"]], var()[["xvar"]]))
            )
          )
      })
    }) |>
      bindEvent(movies(), num(), var(), txt())

    return(
      reactive(
        list(
          # return with text values for x and y
          dplyr::select(
            filtered_txts(),
            title, genre, reviews, oscars, has_oscar,
            year, box_office, director, cast,
            dplyr::all_of(c(var()[["yvar"]], var()[["xvar"]]))
          )
        )
      )
    )

  })
}
